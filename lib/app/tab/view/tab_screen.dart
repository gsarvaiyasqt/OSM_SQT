import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';
import 'package:osm_flutter/app/project_tab/view/project_tab_page.dart';
import 'package:osm_flutter/app/tab/view_model/tab_bar_provider.dart';
import 'package:osm_flutter/utils/common_utils/custom_appbar.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../setting_tab/view/setting_tab_page.dart';
import '../../task_tab/view/task_tab_page.dart';
import '../domain/menu_list.dart';
class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    final tabProvider = context.watch<TabBarProvider>();
    return SafeArea(
      child: Scaffold(
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
}
