import 'package:flutter/material.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/common_utils/custom_drop_down_widget.dart';
import 'package:osm_flutter/utils/common_utils/custom_serch_view_page.dart';
import 'package:osm_flutter/utils/utils.dart';
class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryBackgroundColor,
        title: Text("Create Task",style: CustomTextStyle.boldFont22Style),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            CustomDropDownWidget(
              name: "Project Name",
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CustomSearchViewPage(
                      name: "Project Name",
                    );
                  },));
                });
              },
            ),
            SizedBox(height: 10.sp),
            CustomTextField(
              name: "Title",
              hint: "Title",
            ),
            SizedBox(height: 10.sp),
            Row(
              children: [
                Expanded(child: CustomDatePickerWidget(
                  radius: 5,
                  name: "Start Date",

                )),
                SizedBox(width: 5.sp),
                Expanded(child: CustomDatePickerWidget(
                  radius: 5,
                  name: "End Date",
                )),
              ],
            ),
            SizedBox(height: 10.sp),
            CustomDropDownWidget(
              name: "Assign to",
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CustomSearchViewPage(
                      name: "Project Name",
                    );
                  },));
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
