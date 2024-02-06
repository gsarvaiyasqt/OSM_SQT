import 'package:flutter/material.dart';
import 'package:osm_flutter/utils/utils.dart';

import 'custom_search_view.dart';



class CustomSearchViewPage extends StatefulWidget {
  final String? name;
  // final ValueChanged<CountryModel>? onChange;
  const CustomSearchViewPage({Key? key, this.name}) : super(key: key);

  @override
  State<CustomSearchViewPage> createState() => _CustomSearchViewPageState();
}

class _CustomSearchViewPageState extends State<CustomSearchViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSecondaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: kSecondaryBackgroundColor,
          title: Text(widget.name ?? "",style: CustomTextStyle.boldFont22Style),
        ),
        body: CustomSearchViewDemo(
          // list: widget.list,
          itemDataBuilder: (context, data, index) {
            return Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("${data.dialCode} [${data.name}]" ?? "",style: CustomTextStyle.blackFont18w400),
                ],
              ),
            );
          },
          onTap: () {},
          // onChange: (p0, value) {
          //   if(value.isNotEmpty){
          //     // return p0.where((element) {
          //     //   return ((element.name ?? "").toLowerCase().contains(value.toUpperCase()) || (element.code ?? "").toLowerCase().contains(value.toUpperCase()));
          //     // }).toList();
          //     return p0.where((element) => ((element.name ?? "").toLowerCase().contains(value.toLowerCase()) || (element.dialCode ?? "").toLowerCase().contains(value.toLowerCase()))).toList();
          //   }else{
          //     return p0;
          //   }
          //
          // },
          // selectedItem: (p0) {
          //   //print("selected po is ${p0['dial_code']}");
          //   widget.onChange!(p0);
          //   Navigator.pop(context);
          // },
        )
    );
  }
}
