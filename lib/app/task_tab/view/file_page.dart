import 'package:flutter/material.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../../document/domain/request/delete_document_req_model.dart';
import '../../document/view_model/document_provider.dart';
class FilePage extends StatefulWidget {
  const FilePage({Key? key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();
    final taskDetailData = taskProvider.getTaskDetailsResponse.data?.data?.documents;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body:  Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: List.generate(taskDetailData?.length ?? 0, (index) => Stack(
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
                    uri: taskDetailData?[index].filePath ?? "",fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () async{
                    final documentProvider = context.read<DocumentProvider>();
                    try {
                      await documentProvider.documentDelete(deleteDocumentRequestModel: DeleteDocumentRequestModel(
                          id: taskDetailData?[index].documentId,
                          otherId: taskDetailData?[index].associationId,
                          otherIdType: "TASK"
                      ));
                      setState(() {
                        taskDetailData?.removeWhere((element) => element.documentId == taskDetailData[index].documentId);
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
        ),),
      ),
    );
  }
}

mixin sp {
}
