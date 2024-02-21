import 'package:flutter/material.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/base/view/base_components/loading_view.dart';
import 'package:provider/provider.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../../../utils/utils.dart';
import '../view_model/task_provider.dart';
class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      final taskId = ModalRoute.of(context)?.settings.arguments as int;
      final taskProvider = context.read<TaskProvider>();

      try {
        await taskProvider.getListTaskDetailsLogData(taskId: taskId, isLog: true);
      } catch (e) {
        Toaster.showMessage(context, msg: e.toString());
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final getIdListLogTaskDetailsResponse = taskProvider.getIdListLogTaskDetailsResponse;
    final taskDetailList = getIdListLogTaskDetailsResponse.data?.data?.taskDetails;
    final loading = getIdListLogTaskDetailsResponse.state == Status.LOADING;
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      body: !loading ? ListView.separated(
          itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.sp),
         Row(
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
                 uri: taskDetailList?[index]. profilePic ?? "",fit: BoxFit.cover,
               ),
             ),
             SizedBox(width: 10.sp),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(taskDetailList?[index].displayName ?? "",style: CustomTextStyle.semiBoldFont18Style,),
                   Text(taskDetailList?[index].createdOn != null ? taskDetailList![index].createdOn!.formatCommonDate() : "",style: CustomTextStyle.semiBoldFont18Style,),
                   Text(taskDetailList?[index].details ?? "",style: CustomTextStyle.regularFont18Style,),
                 ],
               ),
             )
           ],
         )
          ],
        );
      },
          separatorBuilder: (context, index) => Divider(),
          itemCount: taskDetailList?.length ?? 0
      ) : Center(child: Loading(color: kSecondaryColor),)
    );
  }
}
