part of utils;

class CustomDatePickerWidget extends StatefulWidget {
   DateTime? initialDate;
   final bool? shoDatePicker;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final EdgeInsets? edgeInsets;
  final String? name;
  final String? hintText;
  final double? radius;
  final TextStyle? textStyle;
  final Function(DateTime)? onSelectedDateTime;
 CustomDatePickerWidget({Key? key,this.initialDate,
   this.firstDate, this.lastDate,  this.radius, this.name, this.edgeInsets, this.onSelectedDateTime, this.shoDatePicker, this.hintText, this.textStyle}) : super(key: key);

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  var selectedDate = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 8.sp),
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(widget.radius ?? 0)
      ),
      child: GestureDetector(
        onTap: ()async{
          if(widget.shoDatePicker == false){
            final dateTime = await showDatePicker(context: context,
                initialDate: widget.initialDate ?? DateTime.now(),
                firstDate: widget.firstDate ?? DateTime(1800),
                lastDate: widget.lastDate ?? DateTime(3000));
            if(dateTime != null){
              setState(() {
                widget.initialDate = dateTime;
                widget.onSelectedDateTime!(dateTime);
                selectedDate = DateFormat.yMd().format(dateTime);
              });
            }
          }else{
          }
        },
        child: Row(
          children: [
            Expanded(child: Text(widget.name ?? "", style: CustomTextStyle.blackRegularFont16Style.copyWith(fontSize: 15.sp))),
            SizedBox(
                height: 24.sp,
                width: 24.sp,
                child: ImageUtil.iconImageClass.calenderIcon),
          ],
        ),
      ),
    );
  }
}
