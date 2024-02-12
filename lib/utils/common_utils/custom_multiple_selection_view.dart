import 'package:flutter/material.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import 'custom_search_view.dart';



class CustomMultiplesSelecationSearchViewPage extends StatefulWidget {
  final String? name;
  final int? projectId;
  final List<SearchModel>? multipleUserList;
  final ValueChanged<SearchModel>? onChange;
  final ValueChanged<List<SearchModel>>? onMultipleSelectedChange;
  final CreateTaskEnum? createTaskEnum;
  const CustomMultiplesSelecationSearchViewPage({Key? key, this.name, this.onChange, this.createTaskEnum, this.projectId, this.onMultipleSelectedChange, this.multipleUserList}) : super(key: key);

  @override
  State<CustomMultiplesSelecationSearchViewPage> createState() => _CustomMultiplesSelecationSearchViewPageState();
}

class _CustomMultiplesSelecationSearchViewPageState extends State<CustomMultiplesSelecationSearchViewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await searchRefresh(SearchArgData(createTaskEnum: widget.createTaskEnum,context: context,project: widget.projectId,multiUserSelection: widget.multipleUserList));

    });
  }



  @override
  Widget build(BuildContext context) {
    final assign = widget.createTaskEnum == CreateTaskEnum.ASSIGN;
    final taskProvider = context.watch<TaskProvider>();
    final isLoading = taskProvider.isLoading;

    print("::::::::::::::::::::::::::Tssmkdmkmdkmdkmdkmdkmdkdmkdmk:::::::");

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
        body: isLoading ? const Center(
          child: CircularProgressIndicator(
            color: kSecondaryColor,
          ),
        ) :RefreshIndicator(
          onRefresh: ()async {
            await context.read<TaskProvider>().resetData();
            await searchRefresh(SearchArgData(createTaskEnum: widget.createTaskEnum,context: context,project: widget.projectId,multiUserSelection: widget.multipleUserList));
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



                final isSelected = widget.multipleUserList?.contains(data);

                print("isSelected is ${isSelected}");

                return GestureDetector(
                  onTap: () {

                    if(assign){

                      setState(() {
                        if(isSelected == true){
                          widget.multipleUserList?.add(data);
                        }else{
                          widget.multipleUserList?.remove(data);
                        }

                      });
                    }else{

                      print(":::::::::::::::::::is Text");
                      widget.onChange!(data);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
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
  Future searchRefresh(SearchArgData searchArgData)async{

    final taskProvider = context.read<TaskProvider>();

    switch(searchArgData.createTaskEnum){

      case CreateTaskEnum.PROJECT:
        await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel());
        await taskProvider.updateSearchList(taskProvider.getProjectAndUserResponse.data?.data?.projectList);
      case CreateTaskEnum.ASSIGN:
        await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel(
            projectId: searchArgData.project,
            multipleUserList: searchArgData.multiUserSelection
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
class SearchArgData{
  BuildContext? context;
  CreateTaskEnum? createTaskEnum;
  int? project;
  List<SearchModel>? multiUserSelection;

  SearchArgData({this.createTaskEnum,this.context,this.multiUserSelection,this.project});
}
