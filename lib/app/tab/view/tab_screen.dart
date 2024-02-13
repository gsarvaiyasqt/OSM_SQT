import 'dart:async';

import '../../../utils/common_utils/custom_timer_appbar.dart';
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
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;

  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  startOrStop() {
    if(startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabProvider = context.watch<TabBarProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: CustomTimerAppbar(height: 100.sp,
          lending: ImageUtil.dummy.profileImage,
          titleText: "Create setting Inner page design",
          action:  Center(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    startOrStop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.sp,vertical: 9.sp),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(startStop ? Icons.play_arrow : Icons.pause,size: 20.sp),
                  ),
                ),

                SizedBox(width: 10.sp),

                Text("$elapsedTime",style: CustomTextStyle.boldFont22Style.copyWith(
                    color: kBackgroundColor
                ))

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
