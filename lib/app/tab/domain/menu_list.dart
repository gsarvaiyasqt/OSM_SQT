import 'package:osm_flutter/utils/utils.dart';

class MenuItem{

  String? icon;
  String? name;

  MenuItem({this.name,this.icon});


  static List<MenuItem> menuList = [

    MenuItem(icon: "$iconPath/home.svg",name: "Home"),
    MenuItem(icon: "$iconPath/project.svg",name: "Project"),
    MenuItem(icon: "$iconPath/task.svg",name: "Task"),
    MenuItem(icon: "$iconPath/setting.svg",name: "Setting"),

  ];


}