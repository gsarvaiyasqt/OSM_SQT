
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/utils.dart';


class CustomRoundedTextField extends StatefulWidget {
  const CustomRoundedTextField({Key? key, this.scrollController,
    this.maxLine, this.startext ,this.headerText , this.isMaxText,this.hint, this.label, this.isOptional, this.focusNode, this.controller, this.onChanged, this.inputType, this.inputFormatters, this.isEnable, this.errorText, this.textInputAction, this.onEditingComplete, this.regex, this.validationMessage, required this.name, this.instructions, this.emptyMessage, this.isSecure, this.suffix, this.prefix, this.maxLength, this.readOnly, this.onTap, this.suffixIcon, this.validatorExtra, this.autofillHints}) : super(key: key);

  final String? hint;
  final String? headerText;
  final String? startext;
  final String? label;
  final bool? isOptional;
  final bool? isMaxText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isEnable;
  final ScrollController? scrollController;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplete;
  final String? regex;
  final String? validationMessage;
  final String name;
  final Iterable<String>? autofillHints;
  final String? instructions;
  final String? emptyMessage;
  final bool? isSecure;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLength;
  final int? maxLine;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final String? Function(String? value)? validatorExtra;

  @override
  State<CustomRoundedTextField> createState() => _CustomRoundedTextFieldState();
}

class _CustomRoundedTextFieldState extends State<CustomRoundedTextField> {
  String? validator(String? text) {
    if ((widget.isOptional ?? true) && (text == null || text.isTrimEmpty)) return null;

    if (text == null) return widget.emptyMessage ?? "Please Enter ${widget.name}.";

    if (text.isTrimEmpty) return widget.emptyMessage ?? "Please Enter ${widget.name}.";

    if (widget.regex != null) {
      final isMatch = RegExp(widget.regex!).hasMatch(text);

      if (!isMatch) {
        return widget.validationMessage ?? "Please Enter Valid ${widget.name}.";
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = EdgeInsets.fromViewPadding(View.of(context).viewInsets, View.of(context).devicePixelRatio);
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.headerText == null ? SizedBox.shrink() : Row(
          children: [
            Text(widget.headerText ?? "",style: CustomTextStyle.blackBoldFont18Style),
            Text(widget.startext ?? "",style: CustomTextStyle.mainColorBoldFont18Style),
          ],
        ),

        widget.headerText == null ? SizedBox.shrink() : SizedBox(height: 10.sp),

        Opacity(
          opacity: widget.isEnable == false ? 0.8 : 1.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp)
            ),
            child: TextFormField(
              scrollPadding: EdgeInsets.only(
                  bottom:  keyboardVisible ? viewInsets.bottom + 30.sp : 120.sp ),
              onTap: widget.onTap,
              readOnly: widget.readOnly ?? false,
              maxLength: widget.maxLength,
              obscureText: widget.isSecure ?? false,
              onEditingComplete: widget.onEditingComplete,
              textInputAction: widget.textInputAction,
              enabled: widget.isEnable,
              keyboardType: widget.inputType,
              inputFormatters: widget.inputFormatters,
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              autofillHints: widget.autofillHints,
              style: CustomTextStyle.blackRegularFont16Style,

              validator: (value) {
                if(widget.validatorExtra != null) {
                  final val = widget.validatorExtra!(value);

                  if(val != null) {
                    return val;
                  }
                }

                return validator(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: widget.maxLine,
              decoration: widget.isMaxText == true  ? InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: widget.suffixIcon,
                suffix: widget.suffix,
                labelText: widget.label,
                hintText: widget.hint,
                hintStyle: CustomTextStyle.mainTextColorRegularFont16Style.copyWith(color: kMainTextColor),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 10.sp),
                errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                focusedErrorBorder:  OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                border: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
              ) : InputDecoration(
                counter: widget.maxLength != null ? const SizedBox.shrink() : null,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: widget.suffixIcon,
                suffix: widget.suffix,
                labelText: widget.label,
                hintText: widget.hint,
                hintStyle: CustomTextStyle.mainTextColorRegularFont16Style.copyWith(color: kMainTextColor),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 10.sp),
                errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                focusedErrorBorder:  OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                border: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: kTextFiledBorderColor), borderRadius: BorderRadius.circular(8.sp)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



