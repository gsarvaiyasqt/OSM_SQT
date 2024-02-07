import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osm_flutter/app/lending/view_model/lending_provider.dart';
import 'package:osm_flutter/app/tab/domain/menu_list.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_utils/custom_appbar.dart';
import '../../../utils/utils.dart';
import '../../tab/view_model/tab_bar_provider.dart';
class SettingTabPage extends StatefulWidget {
  const SettingTabPage({Key? key}) : super(key: key);

  @override
  State<SettingTabPage> createState() => _SettingTabPageState();
}

class _SettingTabPageState extends State<SettingTabPage> {
  @override
  Widget build(BuildContext context) {
    final lendingProvider = context.watch<LendingProvider>();
    final tabProvider = context.read<TabBarProvider>();
    return Scaffold(
      backgroundColor: Color(0xffF3F6F9),
      appBar: CustomAppbar(height: 100.sp,
        lending: ImageUtil.dummy.profileImage,
        titleText: "Create setting Inner page design",
        action:  Center(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.sp,vertical: 9.sp),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(Icons.pause,size: 20.sp),
              ),
              SizedBox(width: 10.sp),
              Text("01:34 hr",style: CustomTextStyle.boldFont22Style.copyWith(
                  color: kBackgroundColor
              ))
            ],
          ),
        ),
      ),
      body: Column(
        children: [

          SizedBox(height: 10.sp,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(15.sp)
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: MenuItem.settingsList.length,
              itemBuilder: (context, index) {
                final settingsData = MenuItem.settingsList[index];
                return InkWell(
                  onTap: () {
                    if(index == 1)
                    lendingProvider.clearAppState();
                    tabProvider.tabChangeIndex(index: 0);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 24.sp,
                                  width: 24.sp,
                                  child: SvgPicture.asset(settingsData.icon ?? "")),
                  
                              SizedBox(width: 15.sp,),
                  
                              Expanded(child: Text(settingsData.name ?? "")),
                  
                              Icon(Icons.arrow_forward_ios_sharp,size: 24.sp,)
                            ],
                          ),
                        ),
                  
                      index == 0 ?  Container(
                        height: 1.sp,
                        width: double.infinity,
                        color: kSecondaryColor.withOpacity(0.10),
                      ) : SizedBox.shrink()
                      ],
                    ),
                  ),
                );
              },),
          )
        ],
      ),
    );
  }
}
