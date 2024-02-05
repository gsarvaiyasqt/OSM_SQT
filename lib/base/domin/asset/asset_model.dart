// import '../../../server_configs/config.dart';
//
// class AssetModel {
//   int? assetId;
//   String? imgPath;
//
//   AssetModel({
//     this.assetId,
//     this.imgPath,
//   });
//
//   String? get imagePahUrl {
//
//     if (imgPath == null) {
//       return null;
//     }
//
//     return ServerConfig.imageUrl + (imgPath ?? "");
//
//   }
//
//   factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
//     assetId: json["asset_id"],
//     imgPath: json["img_path"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "asset_id": assetId,
//     "img_path": imgPath,
//   };
// }