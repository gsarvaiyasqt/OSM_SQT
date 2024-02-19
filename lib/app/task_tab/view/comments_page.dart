import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../view_model/task_provider.dart';
class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final taskId = ModalRoute.of(context)?.settings.arguments as int;
      final taskProvider = context.read<TaskProvider>();
      await taskProvider.getListTaskDetailsData(taskId: taskId,isLog: false);
    });
  }



  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final data = taskProvider.getIdListTaskDetailsResponse.data?.data;
    final taskDetails = data?.taskDetails;
    final documents = data?.documents;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: kBlackColor,
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Comment"
                    ),
                  )),
                  SizedBox(width: 10.sp),
                  Icon(Icons.add),
                  SizedBox(width: 10.sp),
                  Icon(Icons.send),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.sp),
          Expanded(child: ListView.builder(
            itemCount: taskDetails?.length ?? 0,
            itemBuilder: (context, index) {
              final taskDetailsData = taskDetails?[index];
              final testOfList = documents?.where((element) => element.associationId == taskDetailsData?.taskLogDetailId).toList();


              print("testOfList is ${testOfList?.length}");

              return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskDetailsData?.displayName ?? "",style: CustomTextStyle.semiBoldFont18Style,),
                Text(taskDetailsData?.createdOn != null ? taskDetailsData!.createdOn!.formatCommonDate() : "",style: CustomTextStyle.semiBoldFont18Style,),
                Text(taskDetailsData?.details ?? "",style: CustomTextStyle.regularFont18Style,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(taskDetailsData?.documents?.length ?? 0, (imageIndex) => Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                    color: kBlackColor.withOpacity(0.10)
                                )
                            ),
                            child: SizedBox(
                              height: 50.sp,
                              width: 50.sp,
                              child: CustomImageView(
                                uri: taskDetailsData?.documents?[imageIndex].filePath ?? "",fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    border: Border.all(
                                      color: kBlackColor.withOpacity(0.10),
                                    )
                                ),
                                child: Icon(Icons.delete,color: kBlackColor.withOpacity(0.10),))
                        )
                      ],
                    )),
                  ),
                )
              ],
            );
          },))
        ],
      ),
    );
  }
}
