import 'package:osm_flutter/app/task_tab/domain/respones/get_recent_task_response_model.dart';
import 'package:osm_flutter/utils/utils.dart';

class CreateTaskListModel{
  String? date;
  String?time;
  List<TaskList>? testList;
  List<CreateTaskDataModel>? list;

  CreateTaskListModel({this.time,this.date,this.list,this.testList});


 static List<CreateTaskListModel> dummyTaskList = [

   CreateTaskListModel(
     date: "Today",
     time: "4:15 hrs",
     list: [
       CreateTaskDataModel(
         time: "4:15 hrs",
         profilePic: "$dummyImagePath/profile_image.png",
         dashboardName: "Dashboard - OMS",
         title: "Create Inner page design",
         date: "31 Jan 2023",
         name: "Satish Thummar",
         fullTime: "15 Feb 2023",
         messageCount: 1
       )
     ]
   ),

   CreateTaskListModel(
       date: "Yesterday",
       time: "4:15 hrs",
       list: [
         CreateTaskDataModel(
             time: "4:15 hrs",
             profilePic: "$dummyImagePath/profile_image.png",
             dashboardName: "Dashboard - OMS",
             title: "Create Inner page design",
             date: "31 Jan 2023",
             name: "Harshil Patel",
             fullTime: "15 Feb 2023",
             messageCount: 1
         ),

         CreateTaskDataModel(
             time: "4:15 hrs",
             profilePic: "$dummyImagePath/profile_image.png",
             dashboardName: "Dashboard - OMS",
             title: "Develop home page",
             date: "31 Jan 2023",
             name: "Satish Thummar",
             fullTime: "15 Feb 2023",
             messageCount: 100
         ),

         CreateTaskDataModel(
             time: "4:15 hrs",
             profilePic: "$dummyImagePath/profile_image.png",
             dashboardName: "Dashboard - OMS",
             title: "Create social media posts",
             date: "31 Jan 2023",
             name: "Satish Thummar",
             fullTime: "15 Feb 2023",
             messageCount: 5
         ),

         CreateTaskDataModel(
             time: "4:15 hrs",
             profilePic: "$dummyImagePath/profile_image.png",
             dashboardName: "Dashboard - OMS",
             title: "Create Inner page design",
             date: "31 Jan 2023",
             name: "Satish Thummar",
             fullTime: "15 Feb 2023",
             messageCount: 5
         ),
       ]
   ),

 ];

}



class CreateTaskDataModel {
  String? profilePic;
  String? dashboardName;
  String? title;
  String? time;
  String? name;
  String? date;
  String? fullTime;
  num? messageCount;
  CreateTaskDataModel({this.profilePic,this.dashboardName,this.title,this.time,this.name,this.date,this.fullTime,this.messageCount});


}