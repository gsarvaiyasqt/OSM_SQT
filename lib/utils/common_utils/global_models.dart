part of utils;

class Item {
  int id;
  String headerValue;
  bool isExpanded;
  bool checkValue;
  List<String>? subList;

  Item({
    required this.id,
    required this.headerValue,
    this.checkValue = false,
    this.isExpanded = false,
    this.subList
  });
}


List<Item> mehkoList = [
  Item(
      id: 0,
      headerValue: "Private Home Requirements",
      subList: [
        "Adequate food production and food storage capacity for the proposed menu or food products to be prepared",
        "Adequate dry food storage and utensil/equipment storage.",
        "A fully operable kitchen sink with hot and cold water for cleaning and sanitizing purposes.",
      ]
  ),
  Item(
      id: 1,
      headerValue: "Operational Requirements",
      subList: [
        "Adequate food production and food storage capacity for the proposed menu or food products to be prepared",
        "Adequate dry food storage and utensil/equipment storage.",
        "A fully operable kitchen sink with hot and cold water for cleaning and sanitizing purposes.",
      ]
  ),
  Item(
      id: 2,
      headerValue: "Food employee Requirements",
      subList: [
        "Adequate food production and food storage capacity for the proposed menu or food products to be prepared",
        "Adequate dry food storage and utensil/equipment storage.",
        "A fully operable kitchen sink with hot and cold water for cleaning and sanitizing purposes.",
      ]
  ),
  Item(
      id: 3,
      headerValue: "Limitations",
      subList: [
        "Adequate food production and food storage capacity for the proposed menu or food products to be prepared",
        "Adequate dry food storage and utensil/equipment storage.",
        "A fully operable kitchen sink with hot and cold water for cleaning and sanitizing purposes.",
      ]
  ),
];

List<String> reportList = [
  "burger","pizza","chinese","sandwich","donuts","drinks","chiken","Mexican","Italian"
];


class OrderItemModel {
  final String? orderName;
  final int? totalOrder;
  final String? orderDetails;
  final double? itemPrice;
   bool? checkValue;


  OrderItemModel({this.totalOrder, this.orderName, this.orderDetails,this.itemPrice,this.checkValue});
}

class HomeInfoCardModel {
  final String? cardNumber;
  final String? cardText;

  HomeInfoCardModel({this.cardNumber, this.cardText});
}


class CategoryModel {
  final String? imgPath;
  final String? categoryName;
  final String? categoryDetails;
  final double? price;

CategoryModel(
    {this.imgPath, this.categoryName, this.categoryDetails, this.price});
}


class PopModel {
  final String? iconPath;
  final String? value;

  PopModel({this.value, this.iconPath});
}

// List<HomeInfoCardModel> homeInfoList = [
//   HomeInfoCardModel(cardNumber: 70,cardText: "Total Orders"),
//   HomeInfoCardModel(cardNumber: 24,cardText: "Today's Order"),
//   HomeInfoCardModel(cardNumber: 1000,cardText: "Total Earning"),
//   HomeInfoCardModel(cardNumber: 50,cardText: "Completed Orders"),
// ];

// List<String> filterList = [
//   "All","Completed","In Progress","Pending","Canceled"
// ];

List<String> orderStsList = [
 "completed","in_progress","pending","rejected"
];

List<String> menuList = [
  "Restaurant Details",
  "Menu",
  "Reports",
  "Terms & Conditions",
  "Privacy Policy"
];

List<CategoryModel>   categoryList = [
  CategoryModel(
      imgPath: "burger",
      categoryName: "Burger",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "pizza",
      categoryName: "Pizza",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "sandwich",
      categoryName: "Sandwich",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "chicken",
      categoryName: "chicken",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "drink",
      categoryName: "Drinks",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "donuts",
      categoryName: "Dounts",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "most_order",
      categoryName: "Most Ordered",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
      imgPath: "today_special",
      categoryName: "Today's special",
      categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),




];

List<String> orderType = ["Both" , "Can Delivery" , "Pick Up"];
List<String> reportTabList = ["Daily" , "Weekly" , "Monthly"];


List<CategoryModel> itemList = [

  CategoryModel(
    imgPath: "burger1",
    categoryName: "Breakfast Bliss Burger",
    price: 5.0,
    categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),

  CategoryModel(
    imgPath: "burger2",
    categoryName: "Sriracha Swagger Burger",
    price: 5.0,
    categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
    imgPath: "burger3",
    categoryName: "Salsa Sunrise Burger",
    price: 5.0,
    categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),
  CategoryModel(
    imgPath: "burger4",
    categoryName: "The Greek Goddess Burger",
    price: 5.0,
    categoryDetails: "Lorem ipsum dolor sit amet consectetur. Dignissim ut amet lorem turpis diam.",
  ),

];

List<OrderItemModel> orderList = [
  OrderItemModel(totalOrder: 1,orderName: "Margherita Pizza",orderDetails: "Regular (Serves 1, 17.7 cm)",itemPrice: 5.00,checkValue: false),
  OrderItemModel(totalOrder: 2,orderName: "Nachos",orderDetails: "Sharing Platter",itemPrice: 5.00,checkValue: false),
  OrderItemModel(totalOrder: 3,orderName: "Nachos",orderDetails: "Sharing Platter",itemPrice: 5.00,checkValue: false),
  OrderItemModel(totalOrder: 1,orderName: "Nachos",orderDetails: "Sharing Platter",itemPrice: 5.00,checkValue: false),
];


List<PopModel> popList = [
  PopModel(iconPath: "eye_open",value: "view"),
  PopModel(iconPath: "edit",value: "edit"),
  PopModel(iconPath: "delete",value: "close"),
];

List<PopModel> popItemList = [
  PopModel(iconPath: "edit",value: "edit"),
  PopModel(iconPath: "delete",value: "close"),
];

List<PopModel> popMasterList = [
  // PopModel(iconPath: "edit",value: "edit"),
  PopModel(iconPath: "eye_open",value: "view"),
  PopModel(iconPath: "delete",value: "close"),
];

List<PopModel> popItemMasterList = [
  // PopModel(iconPath: "edit",value: "edit"),
  PopModel(iconPath: "circle_cancel",value: "close"),
];


List<String> measurementList = ["secs", "mins", "Hour"];

