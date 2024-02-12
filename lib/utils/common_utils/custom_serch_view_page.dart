import 'custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/app/home_tab/view_model/home_provider.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';


class CustomSearchViewPage extends StatefulWidget {
  final String? name;
  final int? projectId;
  final ValueChanged<SearchModel>? onChange;
  final ValueChanged<List<SearchModel>>? onMultipleSelectedChange;
  final CreateTaskEnum? createTaskEnum;
  const CustomSearchViewPage({Key? key, this.name, this.onChange, this.createTaskEnum, this.projectId, this.onMultipleSelectedChange}) : super(key: key);

  @override
  State<CustomSearchViewPage> createState() => _CustomSearchViewPageState();
}

class _CustomSearchViewPageState extends State<CustomSearchViewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await searchRefresh(widget.createTaskEnum, context,widget.projectId);

    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final isLoading = taskProvider.getProjectAndUserResponse.state == Status.LOADING;
    final isStatusAndPriorityLoading = taskProvider.getGerStatusAndPriorityResponse.state == Status.LOADING;
    return Scaffold(
        backgroundColor: kSecondaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: kSecondaryBackgroundColor,
          leading: GestureDetector(
              onTap: () async{
                await context.read<TaskProvider>().resetData();
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text(widget.name ?? "",style: CustomTextStyle.boldFont22Style),
        ),
        body: (isLoading || isStatusAndPriorityLoading)? Center(
          child: CircularProgressIndicator(
            color: kSecondaryColor,
          ),
        ) :RefreshIndicator(
          onRefresh: ()async {
             await context.read<TaskProvider>().resetData();
             await searchRefresh(widget.createTaskEnum, context,widget.projectId);
          },
          child: WillPopScope(
            onWillPop: () async{
              Navigator.of(context).pop();
             return await context.read<TaskProvider>().resetData();

            },
            child: CustomSearchViewDemo(
              createTaskEnum: widget.createTaskEnum,
              onTap: () {},
               list: taskProvider.list,

              onMultiSelectionChange: (p0) async{
                setState(() {
                  widget.onMultipleSelectedChange!(p0);
                });
                await context.read<TaskProvider>().resetData();

              },

              itemDataBuilder: (context, data, index,isSelected) {
                return Container(
                  color: isSelected == true ? kWhiteColor : Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.name}" ?? "",style: CustomTextStyle.regularFont18Style),
                      ],
                    ),
                  ),
                );
              },

              onChange: (p0, value) {
                if(value.isNotEmpty){
                  return p0.where((element) => ((element.name ?? "").toLowerCase().contains(value.toLowerCase()))).toList();
                }else{
                  return p0;
                }

              },

              selectedItem: (p0) async{
                await context.read<TaskProvider>().resetData();
                widget.onChange!(p0);
                Navigator.pop(context);
                },
            ),
          ),
        )
    );
  }
  Future searchRefresh(CreateTaskEnum? createTaskEnum,BuildContext context,int? project)async{

    final taskProvider = context.read<TaskProvider>();

    switch(createTaskEnum){

      case CreateTaskEnum.PROJECT:
        await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel());
        await taskProvider.updateSearchList(taskProvider.getProjectAndUserResponse.data?.data?.projectList);
        case CreateTaskEnum.ASSIGN:
         await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel(
           projectId: widget.projectId
         ));
         case CreateTaskEnum.STATUS:
        await taskProvider.getStatusAndPriorityTerm(getStatusAndPriorityType: GetStatusAndPriorityType.TaskStatus);
      case CreateTaskEnum.PRIORITY:
      await taskProvider.getStatusAndPriorityTerm(getStatusAndPriorityType: GetStatusAndPriorityType.TaskPriority);
      case null:
        // TODO: Handle this case.
    }

  }



}
