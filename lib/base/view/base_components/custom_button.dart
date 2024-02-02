import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import 'loading_view.dart';

class CustomButton extends StatefulWidget {
  final String? btnText;
  final bool? isLoading;
  final EdgeInsets? btnPadding;
  final Widget? showArrow;
  final Color? btnColor;
  final bool? isBoxShadow;
  final bool? circleShape;
  final double? radius;
  final TextStyle? textStyle;
  final GestureTapCallback? onTap;
  final Widget? child;

  const CustomButton({Key? key, this.btnText, this.isLoading, this.isBoxShadow = true ,this.btnPadding, this.btnColor, this.circleShape, this.onTap, this.radius, this.textStyle, this.showArrow, this.child}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

      borderRadius: BorderRadius.circular(8.sp),
      onTap: widget.isLoading == true ? null : widget.onTap,
      splashColor: Colors.white.withOpacity(0.3),

      child: Container(
        padding:  widget.btnPadding ?? EdgeInsets.symmetric(vertical: 15.sp) ,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 8),
            color: widget.btnColor ?? kPrimaryColor,

          boxShadow: [
            widget.isBoxShadow == true ? BoxShadow(
              offset: Offset(0,4),
              blurRadius: 30,
              spreadRadius: 0,
              color: kBlackColor.withOpacity(0.25)
            ) : BoxShadow(color: Colors.transparent)
          ]

        ),
        child: widget.isLoading ==  true ? const Loading() :

        Center(
            child: widget.btnText == null
            ? widget.child
            : Text(widget.btnText ?? "text",style: widget.textStyle ?? CustomTextStyle.whiteBoldFont18Style,)
        ),
      ),
    );
  }
}
