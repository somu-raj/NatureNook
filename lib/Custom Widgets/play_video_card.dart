// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:nature_nook_app/color/colors.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.controller});
  // final String videoUrl;
  final VideoPlayerController controller;
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final videoUrl = widget.videoUrl;
  //   if (videoUrl.isEmpty) return;
  //   controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
  //     ..initialize()
  //   ..play();
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (_, value, child) {
          // if (!value.isInitialized) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (value.isPlaying) {
                    widget.controller.pause();
                  }
                },
                child: AspectRatio(
                    aspectRatio: value.aspectRatio,
                    child: VideoPlayer(widget.controller)),
              ),
              if (value.isBuffering || !value.isInitialized)
                const CircularProgressIndicator(),
              if (!value.isPlaying && !value.isBuffering)
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                      onPressed: () {
                        if (value.isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                        }
                      },
                      icon: const Icon(
                        /*value.isPlaying ? Icons.pause : */ Icons.play_arrow,
                        color: NatureColor.primary,
                        size: 40,
                      )),
                )
            ],
          );
        });
  }
}
