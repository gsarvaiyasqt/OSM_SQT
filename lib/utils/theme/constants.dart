// Font Sizes
part of utils;

const int primaryColorValue = 0xffEC2A24;
const Color kWhiteColor = Color(0xffFFFFFF);
const Color kPrimaryColor = Color(0xffEC2A24);
const Color kTextPrimaryColor = Color(0xff686263);
const Color kSecondaryColor = Color(0xffF2F2F2);
const Color kTextSecondaryColor = Color(0xff2C2627);
const Color kBlackColor = Color(0xff000000);
const Color kLightGrayColor = Color(0xff666666);
const Color transparentColor = Color(0x00000000);
const Color kTextFiledFillColor = Color(0xFFD9D9D9);
const Color kTextFiledBorderColor = Color(0xFFD9D9D9);
const Color kTextFiledTextColor = Color(0xff444444);
const Color kMainTextColor = Color(0xff4A4A4A);
const Color kGreenColors = Color(0xff4BAD52);
const Color kRedColor = Color(0xffFE4545);
const Color kAppContainerBg = Color(0xffF5F5F5);
const Color kYellowColor = Color(0xffFFD600);
const Color kOrangeColor = Color(0xffFFA800);



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