import 'package:flutter/material.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
class CustomDropDownWidget extends StatefulWidget {
  final String? name;
  final String? selectedItem;
  final GestureTapCallback? onTap;
  final bool? isEditable;
  final bool? isUpdated;
  final List<SearchModel>? multiSelection;
  const CustomDropDownWidget({Key? key, this.name, this.selectedItem, this.onTap, this.multiSelection, this.isEditable, this.isUpdated}) : super(key: key);

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.topLeft,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
               height: 50.sp,
               alignment: Alignment.centerLeft,
               width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5.sp),
                 border: Border.all(
                   color: kBlackColor
                 )
               ),
              child: Padding(
                padding: EdgeInsets.only(right: 10.sp,left: 20.sp),
                child: widget.multiSelection?.isNotEmpty == true?
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(widget.multiSelection?.length ?? 0, (index) {

                      final data = widget.multiSelection?[index];
                      final isAssign = data?.isAssign == 1;
                      return Stack(
                        children: [
                         Container(
                         margin: EdgeInsets.symmetric(horizontal: 8.sp,vertical: 5.sp),
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                          borderRadius: BorderRadius.circular(5.sp)
                        ),
                       child: Text(widget.multiSelection?[index].name ?? "")
                       ),


                          if(widget.isUpdated == true)

                            if(!isAssign)
                            const SizedBox.shrink() else
                            Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () async{
                                if(widget.isUpdated == true){

                                  if(widget.isEditable == true){

                                    await context.read<TaskProvider>().deleteUserInTask(name: widget.multiSelection?[index].name, id: widget.multiSelection?[index].taskUserID);
                                    widget.multiSelection?.removeAt(index);

                                  }

                                }else{
                                  widget.multiSelection?.removeAt(index);
                                }


                                setState(() {});
                                },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Icon(Icons.close,size: 13.sp),
                              ),
                            ),
                          )
                          else

                            Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () async{
                                widget.multiSelection?.removeAt(index);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Icon(Icons.close,size: 13.sp),
                              ),
                            ),
                          )

                        ],
                      );
                    }),
                  ),
                ):
                Row(
                  children: [
                    Expanded(child: Text(widget.selectedItem ?? "Select",style: CustomTextStyle.regularFont18Style)),
                    SizedBox(height: 24.sp,width: 24.sp,child: ImageUtil.iconImageClass.dropdownIcon)
                  ],
                ),
              ),
             ),
          ),
        ),
        Positioned(
            top: 0.sp,
            left: 23.sp,
            child: Container(
                color: kSecondaryBackgroundColor,
                child: Text(widget.name ?? "",style: CustomTextStyle.lightFont16BlackStyle))),

      ],
    );
  }
}
