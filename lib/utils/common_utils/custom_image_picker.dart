// part of utils;
//
// class CustomImagePicker extends ChangeNotifier{
//
//   final ImagePicker imagePicker = ImagePicker();
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//  List<File> _fileList = [];
//  List<File> get fileList => _fileList;
//
//  File? _file;
//  File? get file => _file;
//
//  reset() {
//    _file = null;
//    notifyListeners();
//  }
//
//   getSingleImage(ImageSource imageSource) async{
//     loadingStart();
//     await Future.delayed(const Duration(seconds: 1));
//     try {
//       final singlePhoto = await imagePicker.pickImage(source: imageSource);
//       if(singlePhoto != null){
//         _file = File(singlePhoto.path);
//         await Future.delayed(const Duration(seconds: 1));
//         notifyListeners();
//       }
//       loadingStop();
//     } catch (e) {
//       print(e);
//     }
//
//
//   }
//
//   getMultipleImage()async{
//     loadingStart();
//     final multiplePhoto = await imagePicker.pickMultiImage();
//     if(multiplePhoto.isNotEmpty){
//       for (var element in multiplePhoto) {
//         _fileList.add(File(element.path));
//       }
//       notifyListeners();
//     }
//     loadingStop();
//   }
//
//   loadingStart(){
//     _isLoading = true;
//     notifyListeners();
//   }
//
//   loadingStop(){
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   clearFileList(){
//    _file = null;
//    _fileList = [];
//    notifyListeners();
//   }
//
// }
