import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';

import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/utils/common_utils/custom_search_bar.dart';
import 'package:osm_flutter/app/project_tab/view_model/project_provider.dart';
import 'package:osm_flutter/app/project_tab/components/custom_project_list_component.dart';

import '../domain/dummy/project_list_model.dart';
import '../domain/request/project_get_list_req_model.dart';

class ProjectTabPage extends StatefulWidget {
  const ProjectTabPage({Key? key}) : super(key: key);

  @override
  State<ProjectTabPage> createState() => _ProjectTabPageState();
}

class _ProjectTabPageState extends State<ProjectTabPage> {

  @override
  void initState() {
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

    print("$projectLoader ====  check this  project loader");

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

      body: RefreshIndicator(
        onRefresh: ()async{
          final projectProvider = context.read<ProjectProvider>();
          await projectProvider.getProjectList(projectGetListRequestModel: ProjectGetListRequestModel());
        },
        child: Padding(
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

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: projectLoader ? 8 : projectListData.length,
                  itemBuilder: (context, index) {

                    if(projectLoader){
                      return projectSimmer();
                    }

                  return CustomProjectListComponent(
                    projectData:  projectListData[index],
                    loader: projectLoader,
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget projectSimmer(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: Colors.white
      ),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Row(
              children: [
                SkeletonView(
                  isLoading: true,
                  borderRadius: BorderRadius.circular(100),
                  skeletonBody: SizedBox(
                    height: 40.sp,
                    width: 40.sp,
                  ),
                ),

                SizedBox(width: 10.sp),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonView(
                        isLoading: true,
                        borderRadius: BorderRadius.circular(8.sp),
                        skeletonBody: SizedBox(
                          height: 14.sp,
                          width: 150.sp,
                        ),
                      ),

                      SizedBox(height: 5.sp),

                      SkeletonView(
                        isLoading: true,
                        borderRadius: BorderRadius.circular(8.sp),
                        skeletonBody: SizedBox(
                          height: 14.sp,
                          width: 100.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SkeletonView(
                  isLoading: true,
                  borderRadius: BorderRadius.circular(100),
                  skeletonBody: SizedBox(
                    height: 20.sp,
                    width: 20.sp,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Row(
              children: List.generate(3, (index) {
                return Row(
                  children: [
                    SkeletonView(
                      isLoading: true,
                      borderRadius: BorderRadius.circular(8.sp),
                      skeletonBody: Container(
                        height: 40.sp,
                        width: 80.sp,
                      ),
                    ),
                    SizedBox(width: 10.sp)
                  ],
                );
              }),
            ),
          ),

          SizedBox(height: 5.sp),

          Divider(height: 1.sp,endIndent: 10,indent: 10,color: Colors.black12),

          SizedBox(height: 5.sp),

          Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonView(
                        isLoading: true,
                        borderRadius: BorderRadius.circular(4.sp),
                        skeletonBody: SizedBox(
                          height: 25.sp,
                          width: 150.sp,
                        ),
                      ),
                  
                      SizedBox(height: 5.sp),
                  
                      SkeletonView(
                        isLoading: true,
                        borderRadius: BorderRadius.circular(4.sp),
                        skeletonBody: SizedBox(
                          height: 20.sp,
                          width: 100.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SkeletonView(
                  isLoading: true,
                  borderRadius: BorderRadius.circular(4.sp),
                  skeletonBody: SizedBox(
                    height: 40.sp,
                    width: 40.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
