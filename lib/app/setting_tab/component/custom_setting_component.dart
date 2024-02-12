import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osm_flutter/utils/utils.dart';

class CustomSettingComponent extends StatefulWidget {
  final String? icon;
  final String? name;
  const CustomSettingComponent({super.key, this.icon, this.name});

  @override
  State<CustomSettingComponent> createState() => _CustomSettingComponentState();
}

class _CustomSettingComponentState extends State<CustomSettingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: SvgPicture.asset(widget.icon ?? "")),

                SizedBox(width: 15.sp,),

                Expanded(child: Text(widget.name ?? "")),

                Icon(Icons.arrow_forward_ios_sharp,size: 24.sp,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
