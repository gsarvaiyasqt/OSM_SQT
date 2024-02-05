part of utils;


const String logoPath = "assets/images/logo";
const String graphicsPath = "assets/images/graphics";
const String iconPath = "assets/images/icons";
const String bgImgPath = "assets/images/bg_img";
const String dummyImagePath = "assets/images/dummy_images";

class ImageUtil{
 static ImageClass imageClass = ImageClass();
 static IconImageClass iconImageClass = IconImageClass();
 static LogoImage logo = LogoImage();
 static BackgroundImage backgroundImage = BackgroundImage();
 static DummyImages dummy = DummyImages();
}


class ImageClass{
 Widget get welcomeBgImage => const AssetsImagePictures(assetName: "$logoPath/welcome_screen_bg.png", fit: BoxFit.cover);
}

class LogoImage {

  Widget get appLogo => const AssetsImagePictures(assetName: "$logoPath/logo.png",fit: BoxFit.cover,);

}

class BackgroundImage {

  Widget get createPassword => const AssetsImagePictures(assetName: "$bgImgPath/create_pass.png",fit: BoxFit.contain,);
  Widget get forgot => const AssetsImagePictures(assetName: "$bgImgPath/forgot.png",fit: BoxFit.contain,);
  Widget get verify => const AssetsImagePictures(assetName: "$bgImgPath/verify_img.png",fit: BoxFit.contain,);


}

class IconImageClass{
  Widget get settingsIcon => const CustomSvgPictures.asset("$iconPath/setting.svg",fit: BoxFit.cover,);
  Widget get logoutIcon => const CustomSvgPictures.asset("$iconPath/logout.svg",fit: BoxFit.cover,);
  Widget get eyeCloseIcon => const CustomSvgPictures.asset("$iconPath/eye_close.svg", fit: BoxFit.cover);
  Widget get eyeOpenIcon => const CustomSvgPictures.asset("$iconPath/eye_open.svg");
  Widget get mailIcon => const CustomSvgPictures.asset("$iconPath/mail.svg", fit: BoxFit.contain);
  Widget get verifyIcon => const CustomSvgPictures.asset("$iconPath/blue_tick.svg", fit: BoxFit.cover);
  Widget get addIcon => const CustomSvgPictures.asset("$iconPath/add.svg", fit: BoxFit.cover);
  Widget get filterIcon => const CustomSvgPictures.asset("$iconPath/filter.svg", fit: BoxFit.cover);
  Widget get editIcon => const CustomSvgPictures.asset("$iconPath/edit.svg", fit: BoxFit.cover);
  Widget get exploreIcon => const CustomSvgPictures.asset("$iconPath/explore.svg", fit: BoxFit.fill);
  Widget get callIcon => const CustomSvgPictures.asset("$iconPath/call_icon.svg", fit: BoxFit.cover);
  Widget get locationIcon => const CustomSvgPictures.asset("$iconPath/location.svg", fit: BoxFit.cover);
  Widget get threeDotIcon => const CustomSvgPictures.asset("$iconPath/three_dot.svg", fit: BoxFit.cover);
  Widget get rightArrowIcon => const CustomSvgPictures.asset("$iconPath/right_arrow.svg", fit: BoxFit.cover);
  Widget get profileEditIcon => const CustomSvgPictures.asset("$iconPath/profile_edit.svg", fit: BoxFit.cover);
  Widget get circleCancelIcon => const CustomSvgPictures.asset("$iconPath/circle_cancel.svg",fit: BoxFit.cover);
  Widget get closeBottomSheetIcon => const CustomSvgPictures.asset("$iconPath/close_icon.svg", fit: BoxFit.cover);
  Widget get deleteIcon => const CustomSvgPictures.asset("$iconPath/delete.svg", fit: BoxFit.cover,color: kWhiteColor,);
  Widget get cameraIcon =>  CustomSvgPictures.asset("$iconPath/camera.svg", fit: BoxFit.cover,width: 30.sp,height: 30.sp);
  Widget get galleryIcon => const CustomSvgPictures.asset("$iconPath/gallery.svg", fit: BoxFit.cover);
  Widget get calenderIcon =>  CustomSvgPictures.asset("$iconPath/calender.svg", fit: BoxFit.cover,width: 30.sp,height: 30.sp,);
  Widget get backArrowIcon =>  CustomSvgPictures.asset("$iconPath/back_arrow.svg", fit: BoxFit.cover,color: kBlackColor,width: 30.sp,height: 30.sp,);
}

class DummyImages{

  Widget get profileImage => const AssetsImagePictures(assetName: "$dummyImagePath/profile_image.png", fit: BoxFit.cover);
}


class CustomSvgPictures extends StatelessWidget {
  const CustomSvgPictures.asset(
      this.assetName, {
        Key? key,
        this.width,
        this.height,
        this.fit = BoxFit.cover,
        this.alignment = Alignment.center,
        this.color, this.colorFilter
      }) : super(key: key);

  final double? width;
  final Color? color;
  final String assetName;
  final double? height;
  final BoxFit fit;
  final ui.ColorFilter? colorFilter;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
      color: color,
      colorFilter: colorFilter,
      placeholderBuilder: (context) {
        return const SizedBox.shrink();
      },
    );
  }
}
class AssetsImagePictures extends StatelessWidget {
  final double? width;
  final Color? color;
  final String assetName;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  const AssetsImagePictures({Key? key, required this.assetName, this.width, this.color, this.height, this.fit, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetName,
    fit: fit,
     color: color,
     width: width,
     height: height,
     alignment: alignment ?? Alignment.center,
    );
  }
}



