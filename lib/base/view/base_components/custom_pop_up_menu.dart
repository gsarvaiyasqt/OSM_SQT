import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomPopUpMenu extends StatefulWidget {
  final String? tooltipText;
  final Widget? popBtnIcon;
  final EdgeInsetsGeometry? padding;
  final List<PopupMenuItem>? popMenuList;



  const CustomPopUpMenu({super.key,this.padding, this.tooltipText, this.popBtnIcon, this.popMenuList});

  @override
  State<CustomPopUpMenu> createState() => _CustomPopUpMenuState();
}

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(

      constraints: BoxConstraints(
          minHeight: 1.sp,
          minWidth: 1.sp
      ),
      elevation: 10,
      surfaceTintColor: Colors.white,
      child: widget.popBtnIcon ?? Container(),
      onSelected: (value){
      },
      tooltip: "Filter",

      itemBuilder: (context) {
        return widget.popMenuList  ?? List.generate(widget.popMenuList?.length ?? 0, (index) {
          return  PopupMenuItem(
              height: 0,
              padding: EdgeInsets.zero,
              value: "delete",
              onTap: () {},
              child: const PopUpMenuView(
                popItemText: true,
                dividerColor: Colors.black12,
                itemText: "",
              )
          );
        });
      },
    );
  }
}

class PopUpMenuView extends StatelessWidget {
  final bool? popItemText;
  final Color? dividerColor;
  final String? itemText;
  const PopUpMenuView({super.key, this.popItemText, this.dividerColor, this.itemText});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        SizedBox(height: 10.sp,),

        popItemText == true ?

        Text(itemText ?? "") :

        SvgPicture.asset("$iconPath/$itemText.svg"),

        SizedBox(height: 10.sp,),

        Divider(
          height: 1.sp,
          color : dividerColor ?? Colors.black12
          // ((widget.popMenuList?.length ?? 0) - 1) == index
          //     ? Colors.transparent
          //     : Colors.black12,
        ),
      ],
    );
  }
}

