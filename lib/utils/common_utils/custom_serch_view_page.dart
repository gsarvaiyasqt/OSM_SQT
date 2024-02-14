import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/base/view/base_components/loading_view.dart';

import 'custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';


class CustomSearchViewPage extends StatefulWidget {
  final String? name;
  final int? projectId;
  final ValueChanged<SearchModel>? onChange;
  final List<SearchModel>? selectedItems;
  final ValueChanged<List<SearchModel>>? onMultipleSelectedChange;
  final CreateTaskEnum? createTaskEnum;
  const CustomSearchViewPage({Key? key, this.name, this.onChange, this.createTaskEnum, this.projectId, this.onMultipleSelectedChange, this.selectedItems}) : super(key: key);

  @override
  State<CustomSearchViewPage> createState() => _CustomSearchViewPageState();
}

class _CustomSearchViewPageState extends State<CustomSearchViewPage> {


  List<SearchModel> searchListData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await searchRefresh(widget.createTaskEnum, context,widget.projectId);

      if(widget.selectedItems?.isNotEmpty == true){

        searchListData = widget.selectedItems ?? [];

      }



    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final isLoading = taskProvider.isLoading;
    final assign = widget.createTaskEnum == CreateTaskEnum.ASSIGN;
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
        body: isLoading ? const Center(child: Loading(color: kSecondaryColor),) : RefreshIndicator(
          color: kSecondaryColor,
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

              itemDataBuilder: (context, data, index,isSelected) {

                final selectedItem = searchListData.map((e) => e.projectId).contains(data.projectId);

                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      if(!selectedItem){

                        searchListData.add(data);

                      }else{

                        searchListData.removeWhere((element) => data.projectId == element.projectId);

                      }
                    });
                  },

                  onTap: () async{

                    if(assign){



                    if(!selectedItem){

                      searchListData.add(data);

                    }else{

                      searchListData.removeWhere((element) => data.projectId == element.projectId);


                    }

                    } else{

                      await context.read<TaskProvider>().resetData();
                      widget.onChange!(data);
                      Navigator.pop(context);

                    }

                    setState(() {});

                  },
                  child: Container(
                    color: selectedItem == true ? kWhiteColor : Colors.transparent,
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


              onSubmitTap: () async{
                if(searchListData.isNotEmpty){
                  widget.onMultipleSelectedChange!(searchListData);
                  searchListData = [];
                  await context.read<TaskProvider>().resetData();
                  Navigator.of(context).pop();
                }else{
                  Toaster.showMessage(context, msg: "Please Select Assign Users");

                }



              },
              onChange: (p0, value) {
                if(value.isNotEmpty){
                  return p0.where((element) => ((element.name ?? "").toLowerCase().contains(value.toLowerCase()))).toList();
                }else{
                  return p0;
                }

                },

              // selectedItem: (p0) async{
              //   await context.read<TaskProvider>().resetData();
              //   widget.onChange!(p0);
              //   Navigator.pop(context);
              //   },
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
