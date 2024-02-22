part of utils;



extension StringValidation on String{
  static String get emailValidation =>
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String get mobileValidation =>
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
 bool get isTrimEmpty => trim().isEmpty;
}


extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year <= other.year && month <= other.month && day <= other.day;
  }
}

extension DateTimeFormatterExt on DateTime {

  String formatCommonDate() {
    return DateFormat("dd-MM-yyyy hh:mm").format(this);
  }


  String formatFor({required String format}) {
    return DateFormat(format).format(this);
  }

}

extension StringDateFormatRxt on String{

  String formatDate() {

    var dateTime = DateFormat("dd/MM/yyyy").parse(this);

    return dateTime.toString();
  }

}


extension DurationExt on Duration {

  static Duration? convertFromStr({required String str}) {

    if(str.isTrimEmpty) {
      return null;
    }

    final times = str.split(":");

    final minutes = int.tryParse(times[0]);
    final seconds = int.tryParse(times[1]);

    if(minutes != null) {
      int calSeconds = minutes * 60;

      if(seconds != null) {
        calSeconds = calSeconds + seconds;
      }

      return Duration(seconds: calSeconds);

    }

    return null;

  }

  String formatted() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));

    if(inHours == 0) {
      return "$twoDigitMinutes:$twoDigitSeconds mins";
    } else {
      return "${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds hrs";
    }

  }


}