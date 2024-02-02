import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key,
        FocusNode? focusNode,
        this.hint,
        bool? isOptional,
        bool? isSecure,
        this.controller,
        this.onChanged,
        this.inputType,
        this.inputFormatters,
        this.isEnable,
        this.errorText,
        this.textInputAction,
        this.onEditingComplete,
        this.regex,
        this.validationMessage,
        this.emptyMessage,
        this.name,
        this.suffix, this.instructions, this.maxLength, this.prefix, this.radius, this.hintTextStyle})
      : focusNode = focusNode ?? FocusNode(),
        isOptional = isOptional ?? true,
        isSecure = isSecure ?? false,
        super(key: key);

  final String? hint;
  final bool isOptional;
  final FocusNode focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isEnable;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplete;
  final String? regex;
  final String? validationMessage;
  final String? name;
  final String? instructions;
  final String? emptyMessage;
  final bool isSecure;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLength;
  final double? radius;
  final TextStyle? hintTextStyle;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool hasTypedSomething = false;

  String? error;

  String? validator(String? text) {
    if (widget.isOptional && (text == null || text.isTrimEmpty)) return null;

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

    return TextFormField(
      maxLength: widget.maxLength,
      obscureText: widget.isSecure,
      autofocus: false,
      showCursor: true,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      validator: (value) {
        setState(() {
          error = validator(value);
        });

        return error;
      },
      enabled: widget.isEnable,
      keyboardType: widget.inputType,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: (value) {
        setState(() {
          hasTypedSomething = value.isNotEmpty;
        });

        if(widget.onChanged != null) {
          widget.onChanged!(value);
          widget.controller?.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller?.text.length ?? 0));
        }

        setState(() {
          error = validator(value);
        });

      },
      style:CustomTextStyle.regularFont16Style,
      cursorColor: kPrimaryColor,
      cursorHeight: 20,
      decoration: InputDecoration(
          counter: const SizedBox.shrink(),
          counterStyle: const TextStyle(
              height: 0.0,
              fontSize: 0.0,
              color: Colors.transparent),
          counterText: "",
          labelText: widget.hint ?? "",
          errorStyle: const TextStyle(height: 0,color: Colors.red,fontSize: 0,),
          border:  OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor.withOpacity(0.54)
            )
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kPrimaryColor.withOpacity(0.54)
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kPrimaryColor.withOpacity(0.54)
              )
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kRedColor.withOpacity(0.54)
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kRedColor
              )
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: kPrimaryColor.withOpacity(0.54)
              )
          ),
          contentPadding: EdgeInsets.only(left: widget.prefix == null ? 15.sp : 5.sp,right: 15.sp,bottom: 10.sp)
      ),
    );
  }
}