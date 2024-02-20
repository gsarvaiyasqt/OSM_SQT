import 'dart:async';

import 'package:osm_flutter/app/home_tab/view_model/home_provider.dart';
import 'package:osm_flutter/app/tab/view_model/timer_provider.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../../../timer/timer_notifier.dart';
import '../../../utils/common_utils/custom_timer_appbar.dart';
import '../../task_tab/domain/request/get_recent_task_request_model.dart';
import '../../task_tab/domain/request/start_stop_task_req_model.dart';
import '../domain/menu_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/utils/utils.dart';
import '../../task_tab/view/task_tab_page.dart';
import '../../setting_tab/view/setting_tab_page.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';
import 'package:osm_flutter/app/project_tab/view/project_tab_page.dart';
import 'package:osm_flutter/app/tab/view_model/tab_bar_provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final taskProvider = context.read<TaskProvider>();
      final timeProvider = context.read<TimerNotifier>();
      await taskProvider.getRunningTask();

      final date = taskProvider.getRunningTaskResponse.data?.data?.first.startTime;
      await timeProvider.differenceRunningTime(startDate: date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabProvider = context.watch<TabBarProvider>();
    final timeProvider = context.watch<TimerNotifier>();
    final taskProvider = context.watch<TaskProvider>();

    final getTaskDetailsLoader = taskProvider.getRunningTaskResponse.state == Status.LOADING;
    final getTaskDetailsData = taskProvider.getRunningTaskResponse.data?.data?[0];

    final duration = timeProvider.duration;

    // print("${duration?.inSeconds.remainder(60)} -=====  duration?.inSeconds");

    final fTime = "${duration?.inHours.remainder(60).toString().padLeft(2, '0')}:${duration?.inMinutes.remainder(60).toString().padLeft(2, '0')}";

    // print("${fTime} -=====  finalTime check");

    return SafeArea(
      child: Scaffold(
        appBar: getTaskDetailsData == null ?

        AppBar(toolbarHeight: 0,) :

        CustomTimerAppbar(
          loader: getTaskDetailsLoader,
          height: 100.sp,
          lending: CustomImageView(uri: getTaskDetailsData.projectLogo,fit: BoxFit.cover,placeholder: Icon(Icons.error_outline_rounded,color: Colors.white,)),
          titleText: "${getTaskDetailsData.title}",
          projectText: "${getTaskDetailsData.projectName}",
          action:  Center(
            child: Row(
              children: [
                SkeletonView(
                  isLoading: getTaskDetailsLoader,
                  borderRadius: BorderRadius.circular(100),
                  skeletonBody: Container(
                    height: 40.sp,
                    width: 40.sp,
                  ),
                  child: InkWell(
                    onTap: () async{
                      final startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day - 7,DateTime.now().hour,DateTime.now().minute,DateTime.now().second);
                      final timerProvider = context.read<TimerNotifier>();
                      final taskProvider = context.read<TaskProvider>();
                      final homeProvider = context.read<HomeProvider>();

                      await taskProvider.stopTask(startStopTaskReqModel: StartStopTaskReqModel(
                        projectId: getTaskDetailsData.projectId,
                        taskId: getTaskDetailsData.taskId,
                      ));

                      await taskProvider.getRecentTaskListData(recentTaskRequestModel: RecentTaskRequestModel());

                      await homeProvider.getHomeTaskListData(recentTaskRequestModel: RecentTaskRequestModel(
                          endDate: DateTime.now(),
                          startDate: startDate
                      ));

                      timeProvider.stopTimer();

                      await taskProvider.getRunningTask();

                      final date = taskProvider.getRunningTaskResponse.data?.data?.first.startTime;

                      timeProvider.differenceRunningTime(startDate: date);

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric (horizontal: 9.sp,vertical: 9.sp),
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(getTaskDetailsData.taskId == null ? Icons.play_arrow : Icons.pause,size: 20.sp),
                    ),
                  ),
                ),

                SizedBox(width: 10.sp),

                SkeletonView(
                  isLoading: getTaskDetailsLoader,
                  borderRadius: BorderRadius.circular(8.sp),
                  skeletonBody: SizedBox(
                    width: 80.sp,
                    height: 22.sp,
                  ),
                  child: Text(
                      fTime,
                      style: CustomTextStyle.boldFont22Style.copyWith(
                          color: kBackgroundColor
                      )),
                )
              ],
            ),
          ),
        ),

        backgroundColor: kWhiteColor,

        body: IndexedStack(
          index: tabProvider.currentIndex,
          children: const [
            HomeTabPage(),
            ProjectTabPage(),
            TaskTabPage(),
            SettingTabPage(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 15.sp),
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.sp),
                  topLeft: Radius.circular(20.sp)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(MenuItem.menuList.length, (index) {
              final currentItem = tabProvider.currentIndex == index;
              final menu = MenuItem.menuList[index];
              return GestureDetector(
                onTap: () {
                  context.read<TabBarProvider>().tabChangeIndex(index: index);
                },
                child: AnimatedContainer(
                    curve: Curves.easeInCirc,
                    duration: const Duration(milliseconds: 100),
                    padding: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 9.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: currentItem ?  kBackgroundColor : Colors.transparent
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 24.sp,
                            height: 24.sp,
                            child: CustomSvgPictures.asset(menu.icon ?? "",fit: BoxFit.contain,colorFilter: ColorFilter.mode(currentItem ? kBlackColor : kWhiteColor.withOpacity(0.50), BlendMode.srcIn),)),
                        SizedBox(width: 10.sp),
                        if(currentItem)
                          Text(menu.name ?? "",style: CustomTextStyle.mediumFont14Style),
                      ],
                    )),
              );
            }),
          ),
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: kBackgroundColor,
    //     appBar: CustomAppbar(height: 100.sp,
    //         lending: ImageUtil.dummy.profileImage,
    //         titleText: "Create setting Inner page design",
    //       action:  Center(
    //         child: Row(
    //           children: [
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 9.sp,vertical: 9.sp),
    //               decoration: BoxDecoration(
    //                 color: kBackgroundColor,
    //                 borderRadius: BorderRadius.circular(100),
    //               ),
    //               child: Icon(Icons.pause,size: 20.sp),
    //             ),
    //             SizedBox(width: 10.sp),
    //             Text("01:34 hr",style: CustomTextStyle.boldFont22Style.copyWith(
    //               color: kBackgroundColor
    //             ))
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr";
  }

}
