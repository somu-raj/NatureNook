// Dart imports:
import 'dart:io';
import 'dart:math' hide log;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';

class NatureSearchController extends GetxController {
  ///controller for search text
  TextEditingController searchTextController = TextEditingController();

  ///api services instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///get api urls
  String get getTagsUrl => apiServices.getTags;

  ///declare variables
  RxBool isLoading = false.obs;
  RxString queryText = ''.obs;
  RxList<String> tags = <String>[].obs;

  ///variables for speech to text functionality
  final SpeechToText speech = SpeechToText();
  RxList<LocaleName> localeNames = <LocaleName>[].obs;
  RxString currentLocaleId = ''.obs;
  RxString speechStatus = ''.obs;
  RxBool hasSpeech = false.obs;
  RxDouble minSoundLevel = 0.0.obs;
  RxDouble maxSoundLevel = 1.0.obs;
  RxDouble level = 0.0.obs;
  RxString speechResult = ''.obs;

  ///get products list category wise
  getTagsList() async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(getTagsUrl), {});
    if (response['error'] ?? true) {
      Get.back();
      Utils.mySnackBar(
          title: 'Error Found',
          msg: response['message'] ?? 'Something went wrong, Please try again');
      return;
    }
    tags.value = response['tags'] == null
        ? []
        : List<String>.from(response["tags"]!.map((x) => x.toLowerCase()));
    queryText.value = searchTextController.text;
  }

  ///initialize speech to text state
  Future<void> initSpeechState() async {
    if(Platform.isIOS){
      return;
    }
    var hasSpeechInit = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: false,
      finalTimeout: const Duration(milliseconds: 0),
    );
    if (hasSpeechInit) {
      localeNames.value = await speech.locales();
      var systemLocale = await speech.systemLocale();
      currentLocaleId.value = systemLocale?.localeId ?? '';
    }

    hasSpeech.value = hasSpeechInit;
    if (hasSpeechInit) showSpeechDialog();
  }

  ///listening speech error
  void errorListener(SpeechRecognitionError error) {
    Utils.mySnackBar(title: 'Speech Error!', msg: error.errorMsg);
  }

  /// listening status of speech
  void statusListener(String status) {
    speechStatus.value = status;
  }

  /// start the speech listener
  Future<void> startListening() async {
    await speech.listen(
      onResult: resultListener,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
      localeId: currentLocaleId.value,
      onSoundLevelChange: soundLevelListener,
      listenOptions: SpeechListenOptions(
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      ),
    );
  }

  ///sound level listener
  void soundLevelListener(double levelValue) {
    minSoundLevel.value = min(minSoundLevel.value, levelValue);
    maxSoundLevel.value = max(maxSoundLevel.value, levelValue);
    level.value = levelValue;
  }

  ///for stop the listening
  void stopListening() {
    speech.stop();
    level.value = 0.0;
  }

  ///for cancel the listening
  void cancelListening() {
    speech.cancel();
    level.value = 0.0;
  }

  ///listening results of speech to text
  void resultListener(SpeechRecognitionResult result) {
    speechResult.value = result.recognizedWords;
    queryText.value = speechResult.value;
    if (result.finalResult) {
      Future.delayed(const Duration(seconds: 1)).then((_) async {
        searchTextController.clear();
        searchTextController.text = speechResult.value;
        searchTextController.selection = TextSelection.fromPosition(
            TextPosition(offset: searchTextController.text.length));
      });
    }
  }

  ///show speech to text and results dialog
  void showSpeechDialog() {
    if (!speech.isListening) {
      startListening();
    }
    Get.dialog(AlertDialog(
      backgroundColor: NatureColor.whiteTemp.withOpacity(0.6),
      title: const Center(child: CustomText(text: "Speak", fontSize: 4.8)),
      content: Obx(() {
        if (speech.isNotListening) {
          level.value = 0;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: level.value * 1.5,
                      spreadRadius: level.value * 1.5,
                      color: NatureColor.primary2)
                ],
                color: NatureColor.whiteTemp,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: NatureColor.primary,
                  ),
                  onPressed: () {
                    if (!hasSpeech.value) {
                      initSpeechState();
                    } else {
                      if (!speech.isListening) {
                        startListening();
                      }
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(speechResult.value),
            ),
            InkWell(
              onTap: () {
                if (speechResult.value.isNotEmpty) {
                  Get.back();
                  queryText.value = speechResult.value.toLowerCase();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: NatureColor.whiteTemp.withOpacity(0.3),
                child: Center(
                  child: Text(
                    speech.isListening
                        ? "I'm listening..."
                        : speechResult.value.isNotEmpty
                            ? 'Search'
                            : 'Not listening',
                    style: const TextStyle(
                        color: NatureColor.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    )).then((value) {
      speechResult.value = '';
    });
  }
}
