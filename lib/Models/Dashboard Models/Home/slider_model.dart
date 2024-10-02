// Project imports:
import 'package:nature_nook_app/Models/Dashboard Models/Home/category_model.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Product/products_model.dart';

class SliderModel {
  SliderModel({
    required this.error,
    required this.data,
  });

  final bool? error;
  final List<SliderModelData> data;

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      error: json["error"],
      data: json["data"] == null
          ? []
          : List<SliderModelData>.from(
              json["data"]!.map((x) => SliderModelData.fromJson(x))),
    );
  }
}

class SliderModelData {
  SliderModelData({
    required this.id,
    required this.type,
    required this.typeId,
    required this.image,
    required this.dateAdded,
    required this.data,
  });

  final String? id;
  final String? type;
  final String? typeId;
  final String? image;
  final DateTime? dateAdded;
  final List<dynamic> data;

  factory SliderModelData.fromJson(Map<String, dynamic> json) {
    String type = json["type"] ?? '';
    List<dynamic> dataModelList = json["data"] == null ? [] : json['data'];
    switch (type) {
      case 'categories':
        dataModelList =
            List<CatData>.from(dataModelList.map((x) => CatData.fromJson(x)));
        break;
      case 'products':
        dataModelList =
            List<Product>.from(dataModelList.map((x) => Product.fromJson(x)));
        break;
      default:
        dataModelList = [];
    }
    return SliderModelData(
      id: json["id"],
      type: type,
      typeId: json["type_id"],
      image: json["image"],
      dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
      data: dataModelList,
    );
  }
}
