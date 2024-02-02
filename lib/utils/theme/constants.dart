// Font Sizes
part of utils;

const int primaryColorValue = 0xffEC2A24;
const Color kBackgroundColor = Color(0xffFFFFFF);
const Color kWhiteColor = Color(0xffFFFFFF);
const Color kPrimaryColor = Color(0xff1C212D);
const Color kSecondaryColor = Color(0xff00BC8B);
const Color kBlackColor = Color(0xff000000);
const Color kBlueColor = Color(0xff345BF8);
const Color kYellowColor = Color(0xffFF9E01);
const Color kRedColor = Color(0xffF04141);
const Color KLightGrayColor = Color(0xffF3F6F9);
const Color kSkyBlueColor = Color(0xFF45C5FC);
const Color kGreenColor = Color(0xFF00815F);



final primarySwatchColor = MaterialColor(primaryColorValue, <int, Color>{
  50: const Color(primaryColorValue).withOpacity(0.05),//10%
  100: const Color(primaryColorValue).withOpacity(0.10),//20%
  200: const Color(primaryColorValue).withOpacity(0.20),//30%
  300: const Color(primaryColorValue).withOpacity(0.30),//40%
  400: const Color(primaryColorValue).withOpacity(0.40),//50%
  500: const Color(primaryColorValue).withOpacity(0.50),//60%
  600: const Color(primaryColorValue).withOpacity(0.60),//70%
  700: const Color(primaryColorValue).withOpacity(0.70),//80%
  800: const Color(primaryColorValue).withOpacity(0.80),//90%
  900: const Color(primaryColorValue).withOpacity(0.90),//100%
});





double kFont_18 = 18.sp;
double kFont_16 = 16.sp;
double kFont_14 = 14.sp;
double kFont_12 = 12.sp;
double kFont_13 = 13.sp;
double kFont_25 = 25.sp;
double kFont_20 = 20.sp;
double kFont_35 = 35.sp;
double kFont_24 = 24.sp;
double kFont_10 = 10.sp;

int kDummySecond = 1;

/// character limit
const addressLimit = 100;
const mobileNumberLimit = 13;
const minLimit = 50;
const minCodeLimit = 10;
const notesLimit = 200;
const otpLimit = 6;