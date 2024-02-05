import 'package:flutter/material.dart';
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
    );
  }
}
