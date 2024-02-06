import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/domain/dummy/create_task_response.dart';
import 'package:osm_flutter/app/home_tab/components/custom_recent_task_component.dart';
import 'package:osm_flutter/app/task_tab/route/task_route.dart';
import 'package:osm_flutter/utils/common_utils/custom_search_bar.dart';
import 'package:osm_flutter/utils/utils.dart';

import '../../../utils/common_utils/custom_appbar.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: CustomAppbar(
        height: 100.sp,
        lending: ImageUtil.dummy.profileImage,
        titleText: "Create setting Inner page design",
        action: Center(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 9.sp),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(Icons.pause, size: 20.sp),
              ),
              SizedBox(width: 10.sp),
              Text("01:34 hr",
                  style: CustomTextStyle.boldFont22Style
                      .copyWith(color: kBackgroundColor))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(),
              SizedBox(height: 15.sp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.sp),
                      decoration: BoxDecoration(
                        color: kBlueColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.sp, horizontal: 18.sp),
                              decoration: BoxDecoration(
                                color: kBlueColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.sp)),
                              ),
                              child: Text("02",
                                  style: CustomTextStyle.whiteBoldFont32Style),
                            ),
                          ),
                          SizedBox(height: 39.sp),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Today’s",
                                    style: CustomTextStyle.mediumFont14Style),
                                Text("Task",
                                    style: CustomTextStyle.boldFont14Style
                                        .copyWith(fontSize: 24.sp)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14.sp),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 9.sp, horizontal: 11.sp),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.sp)),
                                ),
                                child: Text("02",
                                    style:
                                        CustomTextStyle.whiteBoldFont32Style),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text("Completed",
                                      style: CustomTextStyle.mediumFont14Style),
                                  Text("Task",
                                      style: CustomTextStyle.boldFont14Style
                                          .copyWith(fontSize: 24.sp)),
                                ],
                              ))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Container(
                          padding: EdgeInsets.all(14.sp),
                          decoration: BoxDecoration(
                            color: kYellowColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 9.sp, horizontal: 11.sp),
                                decoration: BoxDecoration(
                                  color: kYellowColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.sp)),
                                ),
                                child: Text("02",
                                    style:
                                        CustomTextStyle.whiteBoldFont32Style),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text("Leave",
                                      style: CustomTextStyle.mediumFont14Style),
                                  Text("Request",
                                      style: CustomTextStyle.boldFont14Style
                                          .copyWith(fontSize: 24.sp)),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.sp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text("Recent Tasks",
                          style: CustomTextStyle.boldFont24Style)),
                  GestureDetector(
                    onTap: () {
                      TaskRoute.goToCreteTaskPage(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.circular(100.sp),
                      ),
                      child: Icon(Icons.add, color: kWhiteColor, size: 24.sp),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.sp),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: CreateTaskListModel.dummyTaskList.length,
                itemBuilder: (context, index) {
                  final createTaskData =
                      CreateTaskListModel.dummyTaskList[index];
                  return CustomRecentTaskComponent(
                    taskData: createTaskData,
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
