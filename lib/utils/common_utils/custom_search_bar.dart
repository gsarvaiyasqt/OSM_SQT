import 'package:flutter/material.dart';
import 'package:osm_flutter/utils/utils.dart';
class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 22.sp,
              width: 22.sp,
              child: ImageUtil.iconImageClass.searchIcon),
          SizedBox(width: 15.sp),
          Expanded(
            child: TextFormField(
              onChanged: (value) => widget.onChanged?.call(value),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search anything...",
                hintStyle: CustomTextStyle.hintTextStyle
              ),
            ),
          ),
        ],
      ),
    );
  }
}
