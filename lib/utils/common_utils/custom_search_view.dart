import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/utils/common_utils/custom_search_bar.dart';
import 'package:osm_flutter/utils/utils.dart';




class CustomSearchViewDemo<T> extends StatefulWidget {
  final List<T>? list;
  /// this Enum is Use an Multiple user selection
  final CreateTaskEnum? createTaskEnum;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onSubmitTap;
  final Function(T)? selectedItem;
  final Widget Function(BuildContext context,T data,int index,bool? isSelected)? itemDataBuilder;
  final List<T> Function(List<T>,String value)? onChange;
  final Function(List<T>)? onMultiSelectionChange;
  const CustomSearchViewDemo({Key? key, this.list, this.itemDataBuilder, this.selectedItem, this.onChange, this.onTap, this.onMultiSelectionChange, this.createTaskEnum, this.onSubmitTap}) : super(key: key);

  @override
  State<CustomSearchViewDemo<T>> createState() => _CustomSearchViewDemoState<T>();
}

class _CustomSearchViewDemoState<T> extends State<CustomSearchViewDemo<T>> {
  List<T> filterListData = [];
  List<T> multiSelectionListData = [];
  int selected = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      filterListData = widget.list ?? [];

    });
  }


  @override
  Widget build(BuildContext context) {
    final assign = widget.createTaskEnum == CreateTaskEnum.ASSIGN;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                CustomSearchBar(
                  onChanged: (value) {
                    setState(() {
                      if(widget.onChange != null){
                        filterListData =  widget.onChange?.call(widget.list ?? [],value ?? "") ?? [];
                      }
                    });
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 5.sp,bottom: 20.sp),
                      itemCount: filterListData.length,
                      separatorBuilder: (context, index) =>  Divider(height: 4.sp,color: kPrimaryColor.withOpacity(0.10)) /*Divider(height: 1.sp,color: KLightGrayColor.withOpacity(0.2),endIndent: 20.sp,indent: 20.sp)*/,
                      itemBuilder: (context, index) {
                        final isSelected = multiSelectionListData.contains(filterListData[index]);
                        return widget.itemDataBuilder?.call(context,filterListData[index],index,isSelected);
                        return InkWell(
                            onTap: () {


                              if(assign){
                                setState(() {
                                  if(!isSelected){
                                    multiSelectionListData.add(filterListData[index]);
                                  }else{
                                    multiSelectionListData.remove(filterListData[index]);
                                  }

                                });
                              }else{
                                widget.selectedItem?.call(filterListData[index]);
                              }
                              // widget.selectedItem?.call(filterListData[index]);
                            },
                            onLongPress: assign ? (){
                              setState(() {

                                if(!isSelected){
                                  multiSelectionListData.add(filterListData[index]);
                                }else{
                                  multiSelectionListData.remove(filterListData[index]);
                                }

                              });


                            } : null,
                            // onLongPress: () {
                            //   setState(() {
                            //     widget.onMultiSelectionChange!(multiSelectionListData);
                            //  });
                            // },
                            child: widget.itemDataBuilder?.call(context,filterListData[index],index,isSelected)
                        );
                      }),
                ),
              ],
            ),
          ),
          if(assign)
          CustomButton(
            btnColor: kSecondaryColor,
            btnText: "Submit",
            onTap: widget.onSubmitTap,
          ),
          SizedBox(height: 10.sp,)
        ],
      ),
    );
  }
}
