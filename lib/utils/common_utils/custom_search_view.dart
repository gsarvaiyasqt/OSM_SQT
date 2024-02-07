import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osm_flutter/utils/common_utils/custom_search_bar.dart';
import 'package:osm_flutter/utils/utils.dart';




class CustomSearchViewDemo<T> extends StatefulWidget {
  final List<T>? list;
  final GestureTapCallback? onTap;
  final Function(T)? selectedItem;
  final Widget Function(BuildContext context,T data,int index)? itemDataBuilder;
  final List<T> Function(List<T>,String value)? onChange;
  const CustomSearchViewDemo({Key? key, this.list, this.itemDataBuilder, this.selectedItem, this.onChange, this.onTap}) : super(key: key);

  @override
  State<CustomSearchViewDemo<T>> createState() => _CustomSearchViewDemoState<T>();
}

class _CustomSearchViewDemoState<T> extends State<CustomSearchViewDemo<T>> {
  List<T> filterListData = [];
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
    print('getContactDataRes  list data ${filterListData}');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: ListView.separated(
                itemCount: filterListData.length,
                separatorBuilder: (context, index) =>  Divider(height: 1.sp,color: KLightGrayColor.withOpacity(0.2),endIndent: 20.sp,indent: 20.sp),
                itemBuilder: (context, index) {
                  selected = index;
                  return InkWell(
                      onTap: () {
                        widget.selectedItem?.call(filterListData[index]);
                      },
                      child: widget.itemDataBuilder?.call(context,filterListData[index],index));
                }),
          ),
        ],
      ),
    );
  }
}
