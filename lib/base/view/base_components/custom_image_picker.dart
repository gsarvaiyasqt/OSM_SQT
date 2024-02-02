
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomImagePicker {
  XFile? imageFile;
  Uint8List? imgBytesData;

  final _picker = ImagePicker();

  Function(List<String>)? onFile;
  Function(List<XFile>)? onMultiSelectFile;
  Function(bool)? onLoading;
  Function(String)? onError;

  bool isLoading = false;

  bottom(BuildContext context, {bool? haveInstructions}){

    showModalBottomSheet(
        backgroundColor: Colors.transparent,

        context: context, builder: (context){
      return PickImageSheet(onCameraClick: (){
        Navigator.pop(context);
        pick(ImageSource.camera);
      },onGalleryClick: (){
        Navigator.pop(context);
        pick(ImageSource.gallery);
      },haveInstructions: haveInstructions,);

    });

  }

  bottomMultiple(BuildContext context, {bool? haveInstructions}){

    showModalBottomSheet(
        backgroundColor: Colors.transparent,

        context: context, builder: (context){
      return PickImageSheet(onCameraClick: (){
        Navigator.pop(context);
        pick(ImageSource.camera);
      },onGalleryClick: (){
        Navigator.pop(context);
        pickMultipleImages();
      },haveInstructions: haveInstructions,);

    });

  }

  bottomVideo(BuildContext context, {bool? haveInstructions}){

    showModalBottomSheet(
        backgroundColor: Colors.transparent,

        context: context, builder: (context){
      return PickImageSheet(onCameraClick: (){
        Navigator.pop(context);
        pickVideo(ImageSource.camera);
      },onGalleryClick: (){
        Navigator.pop(context);
        pickVideo(ImageSource.gallery);
      },haveInstructions: haveInstructions,);

    });

  }

  setIsLoading(bool isLoading){
    if(onLoading != null){
      this.isLoading = isLoading;
      onLoading!(isLoading);
    }
  }

  updateFileWithPath(XFile file){
    if(onFile != null){
      onFile!([file.path]);
    }
  }

  onErrorCall(String error){
    if(onError != null){
      onError!(error);
    }
  }

  pick(ImageSource source) async {
    setIsLoading(true);
    try {
      final image = await _picker.pickImage(source: source,imageQuality: 80);

      if (image != null){
        imageFile = image;
        updateFileWithPath(image);
        imgBytesData = await image.readAsBytes();
      }

    } catch (e) {
      onErrorCall("There is some issue with selected image, please select some other image.");
    } finally {
      setIsLoading(false);
    }
  }

  pickMultipleImages() async {
    setIsLoading(true);
    try {

      final images = await _picker.pickMultiImage(imageQuality: 80);

      if (images.isNotEmpty){
        imageFile = images.first;
        onMultiSelectFile!(images);
        imgBytesData = await images.first.readAsBytes();
      }

    } catch (e) {
      onErrorCall("There is some issue with selected image, please select some other image.");
    } finally {
      setIsLoading(false);
    }
  }

  pickVideo(ImageSource source) async {
    setIsLoading(true);
    try {
      final image = await _picker.pickVideo(source: source, maxDuration: Duration(seconds: 200));

      if (image != null){
        imageFile = image;
        updateFileWithPath(image);
        imgBytesData = await image.readAsBytes();
      }

    } catch (e) {
      onErrorCall("There is some issue with selected image, please select some other image.");
    } finally {
      setIsLoading(false);
    }
  }

}

class PickImageSheet extends StatelessWidget {
  const PickImageSheet({Key? key, required this.onCameraClick, required this.onGalleryClick, this.haveInstructions}) : super(key: key);

  final Function onCameraClick;
  final Function onGalleryClick;
  final bool? haveInstructions;

  @override
  Widget build(BuildContext context) {

    final imageUploadInstructions = haveInstructions == true ? [
      "Please upload profile pic with visible face.",
      "Make sure there is only one person in the frame."
    ] : [];

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.sp,vertical: 20.sp),
          decoration: BoxDecoration(
                 color: kBackgroundColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50.sp),topLeft: Radius.circular(50.sp)),
          ),
          child: SafeArea(
            top: false,
            child: Material(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Row(
                      children: [
                        Expanded(child: Text("Upload Photo",style: CustomTextStyle.semiBoldFont18Style)),

                        SizedBox(
                            width: 44.sp,
                            height: 44.sp)
                      ],
                    ),

                    SizedBox(height: 15.sp),

                    // ListView.builder(itemBuilder: (context, index) {
                    //
                    //   return Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 7.5.sp),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Container(
                    //           height: 9.sp,
                    //           width: 9.sp,
                    //           margin: EdgeInsets.only(right: 10.sp,top: 7.sp),
                    //           decoration: const BoxDecoration(
                    //             color: kBlackColor,
                    //             shape: BoxShape.circle,
                    //           ),
                    //         ),
                    //         Expanded(child: Text(imageUploadInstructions[index], style: CustomTextStyle.secondarySmall14W400,)),
                    //       ],
                    //     ),
                    //   );
                    //
                    // },itemCount: imageUploadInstructions.length,shrinkWrap: true, physics: const NeverScrollableScrollPhysics()),

                    SizedBox(height: 15.sp),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Expanded(
                            child: InkWell(
                              onTap: (){
                                onGalleryClick();
                              },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor,
                                      border: Border.all(color: kBlackColor)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.sp),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 40.sp,
                                          width: 40.sp,
                                          child: ImageUtil.iconImageClass.galleryIcon),
                                      Text("Gallery",style: CustomTextStyle.semiBoldFont18Style)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(width: 20.sp),

                          Expanded(
                            child: InkWell(
                              onTap: (){
                                onCameraClick();
                              },
                                 child: Container(
                                   decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                     color: kWhiteColor,
                                     border: Border.all(color: kBlackColor)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.sp),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 40.sp,
                                          width: 40.sp,
                                          child: ImageUtil.iconImageClass.cameraIcon),
                                      Text("Camera",style: CustomTextStyle.semiBoldFont18Style)
                                    ],
                                  ),
                                ),
                              ),
                            ),


                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20.sp,
          right: 10.sp,
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  width: 44.sp,
                  height: 44.sp,
                  alignment: Alignment.center,
                  // child: ImageUtil.icons.close
              )),
        )
      ],
    );
  }
}


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
//  getSingleImage(ImageSource imageSource) async{
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
//
//   }
//
//
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
