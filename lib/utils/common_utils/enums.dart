part of utils;

enum Status { LOADING, COMPLETED, ERROR, UNAUTHORISED }
// enum OrderItemStatus { completed, not_compelted}

enum OrderStatus {
  all(value: "All",apiValue: "all"),
  inProgress(value: "In Progress",apiValue: "in_progress"),
  completed(value: "Completed",apiValue: "completed"),
  pending(value: "Pending",apiValue: "pending"),
  cancel(value: "Canceled",apiValue: "cancelled"),
  delivered(value: "Delivered",apiValue: "delivered"),
  readyForPickup(value: "Ready For Pickup",apiValue: "ready_for_pickup"),
  picked(value: "Picked",apiValue: "picked"),
  rejected(value: "Rejected",apiValue: "rejected"),
  inDelivery(value: "In Delivery",apiValue: "in_delivery");


  const OrderStatus({required this.value,required this.apiValue});

  final String value;
  final String apiValue;

  static OrderStatus? fromSTR({required String? str}) {
    try {
      return OrderStatus.values.firstWhere((element) => element.value == str);
    } catch (e) {
      return null;
    }
  }
}

enum RestaurantType {
  restaurantType(value: "restaurantType"),
  mehkoType(value:"mehko");

  const RestaurantType({required this.value});

  final String value;

  static RestaurantType? fromStr ({required String? str}){
    try {
      return RestaurantType.values.firstWhere((element) => element.value == str);
    } catch (e) {
      return null;
    }
  }

}

enum ApproveType {
  acceptType(value:"accept"),
  pendingType(value:"pending"),
  rejectType(value:"reject");

  const ApproveType({required this.value});

  final String value;

  static ApproveType? fromStr ({required String? str}){
    try {
      return ApproveType.values.firstWhere((element) => element.value == str);
    } catch (e) {
      return null;
    }
  }

}


enum OrderItemStatus {
  completed(value: "completed"),
  notComplete(value: "not_compelted");

  const OrderItemStatus({required this.value});

  final String value;

  static RestaurantType? fromStr ({required String? str}){
    try {
      return RestaurantType.values.firstWhere((element) => element.value == str);
    } catch (e) {
      return null;
    }
  }

}

enum GetTermType {
  cuisinType(value: "restaurant_cuisin_type"),
  resOrderType(value: "restaurant_order_type"),
  resTimeType(value: "time_type"),
  orderStatusType(value: "order_status_type"),
  currencyType(value: "currency_type");

  const GetTermType({required this.value});

  final String value;

  static GetTermType? fromStr ({required String? str}){
    try {
      return GetTermType.values.firstWhere((element) => element.value == str);
    } catch (e) {
      return null;
    }
  }

}

enum CreateTaskEnum{

  PROJECT,ASSIGN,STATUS,PRIORITY

}

enum PriorityType {
  normalType(value: "Normal"),
  highType(value: "High"),
  lowType(value: "Low");


  const PriorityType({required this.value});

  final String value;

  static PriorityType? fromStr ({required String? str}){
    try {
      return PriorityType.values.firstWhere((element) => element.value == str);
    } catch (e) {
      return null;
    }
  }

}


Widget? priorityFunc({String? priority}){

  switch(priority){

    case "Normal":
      return ImageUtil.iconImageClass.normalIcon;

    case "Highest":
      return ImageUtil.iconImageClass.doubleArrow;

    case "High":
      return ImageUtil.iconImageClass.doubleArrow;

    case "Low":
      return ImageUtil.iconImageClass.downIcon;
  }

  return SizedBox.shrink();
}


formattedTime({required int timeInSecond}) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute:$second";
}


Widget? statusFunc({String? status}){
  switch(status){

    case "In Process":
      return ImageUtil.iconImageClass.blueClockIcon;

    case "Not Started":
      return ImageUtil.iconImageClass.onHoldIcon;

    case "Closed":
      return ImageUtil.iconImageClass.verifiedIcon;

    case "On Hold":
      return ImageUtil.iconImageClass.onHoldIcon;
  }

  return SizedBox.shrink();
}











