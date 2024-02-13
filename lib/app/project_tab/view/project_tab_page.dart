import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';

import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/utils/common_utils/custom_search_bar.dart';
import 'package:osm_flutter/app/project_tab/view_model/project_provider.dart';
import 'package:osm_flutter/app/project_tab/components/custom_project_list_component.dart';

import '../domain/request/project_get_list_req_model.dart';

class ProjectTabPage extends StatefulWidget {
  const ProjectTabPage({Key? key}) : super(key: key);

  @override
  State<ProjectTabPage> createState() => _ProjectTabPageState();
}

class _ProjectTabPageState extends State<ProjectTabPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final projectProvider = context.read<ProjectProvider>();
      await projectProvider.getProjectList(projectGetListRequestModel: ProjectGetListRequestModel());
    });
  }

  @override
  Widget build(BuildContext context) {

    final projectProvider = context.watch<ProjectProvider>();
    final projectLoader = projectProvider.getProjectListResponse.state == Status.LOADING;
    final projectListData = projectProvider.projectListData;

    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,

      // appBar: CustomAppbar(height: 100.sp,
      //   lending: ImageUtil.dummy.profileImage,
      //   titleText: "Create setting Inner page design",
      //   action:  Center(
      //     child: Row(
      //       children: [
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 9.sp,vertical: 9.sp),
      //           decoration: BoxDecoration(
      //             color: kBackgroundColor,
      //             borderRadius: BorderRadius.circular(100),
      //           ),
      //           child: Icon(Icons.pause,size: 20.sp),
      //         ),
      //         SizedBox(width: 10.sp),
      //         Text("01:34 hr",style: CustomTextStyle.boldFont22Style.copyWith(
      //             color: kBackgroundColor
      //         ))
      //       ],
      //     ),
      //   ),
      // ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20.sp,),

              CustomSearchBar(),

              SizedBox(height: 15.sp,),
          
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text("Projects",
                          style: CustomTextStyle.boldFont24Style)),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.circular(100.sp),
                      ),
                      child: Icon(Icons.add, color: kWhiteColor, size: 24.sp),
                    ),
                  )
                ],
              ),
          
              SizedBox(height: 15.sp,),
              
              Skeleton(
                isLoading: projectLoader,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: projectListData.length,
                  itemBuilder: (context, index) {
                    print("LENGTH=======${projectListData.length}");
                  return CustomProjectListComponent(
                    projectData: projectListData[index],
                  );
                },),
              )

            ],
          ),
        ),
      ),
    );
  }
}
