import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/document/domain/request/delete_document_req_model.dart';
import 'package:osm_flutter/app/document/view_model/document_provider.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/save_comment_response_data.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/base/view/base_components/loading_view.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../base/view/base_components/custom_image_picker.dart';
import '../../../base/view/base_components/custom_image_view.dart';
import '../../../base/view/base_components/multi_selection_images.dart';
import '../domain/request/comment_save_req_data_model.dart';
import '../view_model/task_provider.dart';
class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  TextEditingController commentCon = TextEditingController();

  CustomImagePicker customImagePicker = CustomImagePicker();

  List<File> commentListOfFile = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final taskId = ModalRoute.of(context)?.settings.arguments as int;
      final taskProvider = context.read<TaskProvider>();

      customImagePicker.onMultiSelectFile = (value){


        setState(() {

          for (var element in value) {
            commentListOfFile.add(File(element.path));
          }


        });


      };

      await taskProvider.getListTaskDetailsData(taskId: taskId,isLog: false);

    });
  }



  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)?.settings.arguments as int;
    final taskProvider = context.watch<TaskProvider>();
    final loading = taskProvider.getIdListTaskDetailsResponse.state == Status.LOADING;
    final data = taskProvider.getIdListTaskDetailsResponse.data?.data;
    final projectId = taskProvider.getTaskDetailsResponse.data?.data?.task?.projectId;
    final taskDetails = data?.taskDetails;
    final documents = data?.documents;
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      body: !loading ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller: commentCon,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Comment"
                    ),
                  )),
                  SizedBox(width: 10.sp),
                  GestureDetector(
                      onTap: () {
                        customImagePicker.pickMultipleImages();
                        setState(() {

                        });
                      },
                      child: const Icon(Icons.add)),
                  SizedBox(width: 10.sp),
                  GestureDetector(
                      onTap: () async{

                        if(commentCon.text.isNotEmpty){
                          try {

                            await context.read<TaskProvider>().saveCommentReqData(commentSaveReqData: CommentSaveReqData(
                                taskId: taskId,
                                projectId: projectId,
                                details: commentCon.text,
                                taskLogDetailId: 0,
                                list: commentListOfFile));
                            commentListOfFile = [];
                            commentCon.clear();
                          } catch (e) {
                            Toaster.showMessage(context, msg: e.toString());
                          }
                        }else{

                          Toaster.showMessage(context, msg: "Please Enter Comment");

                        }


                      },
                      child: const Icon(Icons.send)),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.sp),
          if(commentListOfFile.isNotEmpty)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: List.generate(commentListOfFile.length, (index) => Stack(
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
                      child: Image.file(File(commentListOfFile[index].path)),
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          commentListOfFile.remove(commentListOfFile[index]);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                color: kBlackColor.withOpacity(0.10),
                              )
                          ),
                          child: Icon(Icons.delete,color: kBlackColor.withOpacity(0.10),)),
                    )
                )
              ],
            ),),
          ),
          SizedBox(height: 10.sp),

          Expanded(child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: taskDetails?.length ?? 0,
            itemBuilder: (context, index) {
              final taskDetailsData = taskDetails?[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10.sp),
                  Container(
                    height: 50.sp,
                    width: 50.sp,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomImageView(
                      uri: taskDetailsData?.profilePic ?? "",fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Expanded(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(taskDetailsData?.displayName ?? "",style: CustomTextStyle.semiBoldFont18Style,)),
                          GestureDetector(
                              onTap: () async{
                                await context.read<TaskProvider>().deleteTaskCommentDetails(id: taskDetailsData?.taskLogDetailId);
                              },
                              child: const Icon(Icons.delete,color: kBlackColor)),
                        ],
                      ),
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
                                  child: GestureDetector(
                                    onTap: () async {
                                      final documentProvider = context.read<DocumentProvider>();
                                      try {
                                        await documentProvider.documentDelete(deleteDocumentRequestModel: DeleteDocumentRequestModel(
                                                                          id: taskDetailsData?.documents?[imageIndex].documentId,
                                                                          otherId: taskDetailsData?.documents?[imageIndex].associationId,
                                                                          otherIdType: "TASK"
                                                                        ));
                                        setState(() {
                                          taskDetailsData?.documents?.removeWhere((element) => element.documentId == taskDetailsData.documents?[imageIndex].documentId);
                                        });

                                      } catch (e) {

                                       Toaster.showMessage(context, msg: e.toString());

                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.sp),
                                            border: Border.all(
                                              color: kBlackColor.withOpacity(0.10),
                                            )
                                        ),
                                        child: Icon(Icons.delete,color: kBlackColor.withOpacity(0.10),)),
                                  )
                              )
                            ],
                          )),
                        ),
                      )
                    ],
                                ),
                  ),
                ],
              );
          },))
        ],
      ) : const Center(child: Loading(color: kSecondaryColor),)
    );
  }
}
