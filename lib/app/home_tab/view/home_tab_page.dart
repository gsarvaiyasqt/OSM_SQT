import 'package:flutter/material.dart';
import 'package:osm_flutter/app/home_tab/view_model/home_provider.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_recent_task_request_model.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_status_count.dart';
import 'package:osm_flutter/app/auth/domain/dummy/create_task_response.dart';
import 'package:osm_flutter/app/home_tab/components/custom_recent_task_component.dart';
import 'package:osm_flutter/app/task_tab/route/task_route.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/utils/common_utils/custom_search_bar.dart';
import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_utils/custom_appbar.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      final startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day - 7,DateTime.now().hour,DateTime.now().minute,DateTime.now().second);

      final homeProvider = context.read<HomeProvider>();

      await homeProvider.getTaskCount(getStatusCountRequestModel: GetStatusCountRequestModel());

      await homeProvider.getHomeTaskListData(recentTaskRequestModel: RecentTaskRequestModel(
        endDate: DateTime.now(),
        startDate: startDate
      ));

    });

  }


  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final recentLoader = homeProvider.resentTaskResponse.state == Status.LOADING;
    final isLoading = homeProvider.getStatusCountResponse.state == Status.LOADING;
    final resentListData =  homeProvider.listData;

    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      // appBar: CustomAppbar(height: 100.sp,
      //     lending: ImageUtil.dummy.profileImage,
      //     titleText: "Create setting Inner page design",
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
      //           color: kBackgroundColor
      //         ))
      //       ],
      //     ),
      //   ),
      // ),
      body: /*isLoading ?
      const Center(child: CircularProgressIndicator(),) :*/
      Padding(
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(),

              SizedBox(height: 15.sp),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.sp),
                      decoration: BoxDecoration(
                        color: kBlueColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Column(
                        children: [

                          Align(
                            alignment: Alignment.centerRight,
                            child: SkeletonView(
                              isLoading: isLoading,
                              borderRadius: BorderRadius.circular(100),
                              skeletonBody: ClipRRect(
                                  child: Container(
                                    height: 70.sp,
                                    width: 70.sp,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                  )),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.sp,horizontal: 18.sp),
                                  decoration: const BoxDecoration(
                                    color: kBlueColor,
                                    shape: BoxShape.circle
                                  ),
                                  child: Text("0${homeProvider.todayCount}" ?? "",style: CustomTextStyle.whiteBoldFont32Style),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 54.sp),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SkeletonView(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  isLoading: isLoading,
                                  skeletonBody: SizedBox(
                                    height: 14.sp,
                                    width: 70.sp,
                                  ),
                                  child: Text("Today’s",style: CustomTextStyle.mediumFont14Style),
                                ),

                                isLoading ? SizedBox(height: 10,) : SizedBox.shrink(),

                                SkeletonView(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  isLoading: isLoading,
                                  skeletonBody: SizedBox(
                                    height: 24.sp,
                                    width: 70.sp,
                                  ),
                                  child: Text("Task",style: CustomTextStyle.boldFont14Style.copyWith(
                                      fontSize: 24.sp
                                  )),

                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10.sp),

                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 22.5.sp),
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Align(
                                alignment: Alignment.centerRight,
                                child: SkeletonView(
                                  isLoading: isLoading,
                                  borderRadius: BorderRadius.circular(100),
                                  skeletonBody: ClipRRect(
                                      child: Container(
                                        height: 50.sp,
                                        width: 50.sp,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                      )),
                                  child: Container(
                                padding: EdgeInsets.symmetric(vertical: 9.sp,horizontal: 11.sp),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                    shape: BoxShape.circle
                                ),
                                child: Text("${homeProvider.comp ?? 0}",style: CustomTextStyle.whiteBoldFont32Style.copyWith(fontSize: 25.sp)),
                              ),)),

                              SizedBox(
                                width: 15.sp,
                              ),

                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonView(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    isLoading: isLoading,
                                    skeletonBody: SizedBox(
                                      height: 14.sp,
                                      width: 70.sp,
                                    ),
                                    child: Text("Completed",style: CustomTextStyle.mediumFont14Style),
                                  ),

                                  isLoading ? SizedBox(height: 10.sp,) : SizedBox.shrink(),

                                  SkeletonView(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    isLoading: isLoading,
                                    skeletonBody: SizedBox(
                                      height: 14.sp,
                                      width: 70.sp,
                                    ),
                                    child: Text("Task",style: CustomTextStyle.boldFont14Style.copyWith(
                                        fontSize: 24.sp
                                    )),
                                  ),

                                ],
                              ))
                            ],
                          ),
                        ),

                        SizedBox(height: 10.sp),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 22.5.sp),
                          decoration: BoxDecoration(
                            color: kYellowColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Align(
                                alignment: Alignment.centerRight,
                                child: SkeletonView(
                                  isLoading: isLoading,
                                  borderRadius: BorderRadius.circular(100),
                                  skeletonBody:    ClipRRect(
                                      child: Container(
                                        height: 50.sp,
                                        width: 50.sp,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                      )),
                                  child: Container(
                                padding: EdgeInsets.symmetric(vertical: 9.sp,horizontal: 11.sp),
                                decoration: BoxDecoration(
                                  color: kYellowColor,
                                  shape: BoxShape.circle
                                ),
                                child: Text("0${homeProvider.leave ?? 0}",style: CustomTextStyle.whiteBoldFont32Style.copyWith(fontSize: 25.sp)),
                              ))),

                              SizedBox(width: 15.sp),

                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SkeletonView(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    isLoading: isLoading,
                                    skeletonBody: SizedBox(
                                      height: 14.sp,
                                      width: 70.sp,
                                    ),
                                    child: Text("Leave",style: CustomTextStyle.mediumFont14Style),
                                  ),

                                  isLoading ? SizedBox(height: 10.sp,) : SizedBox.shrink(),

                                  SkeletonView(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    isLoading: isLoading,
                                    skeletonBody: SizedBox(
                                      height: 14.sp,
                                      width: 70.sp,
                                    ),
                                    child: Text("Request",style: CustomTextStyle.boldFont14Style.copyWith(
                                        fontSize: 24.sp
                                    )),
                                  ),


                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: 10.sp),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SkeletonView(
                    borderRadius: BorderRadius.circular(8.sp),
                    isLoading: recentLoader,
                    skeletonBody: SizedBox(
                      height: 24.sp,
                      width: 70.sp,
                    ),
                    child: Expanded(
                        child: Text("Recent Tasks",
                            style: CustomTextStyle.boldFont24Style)),
                  ),

                  Spacer(),

                  SkeletonView(
                    borderRadius: BorderRadius.circular(100.sp),
                    isLoading: recentLoader,
                    skeletonBody: SizedBox(
                      height: 50.sp,
                      width: 50.sp,
                    ),
                    child:  GestureDetector(
                      onTap: () {
                        TaskRoute.goToCreteTaskPage(context,TaskUpdateModel(
                            id: null,
                            isUpdate: false
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: kBlueColor,
                          borderRadius: BorderRadius.circular(100.sp),
                        ),
                        child: Icon(Icons.add, color: kWhiteColor, size: 24.sp),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10.sp),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                reverse: true,
                itemCount:  recentLoader ? 5 : resentListData.length,
                itemBuilder: (context, index) {

                  if(recentLoader){
                    return homeCardSimmer(recentLoader:recentLoader);
                  }

                  final createTaskData = resentListData[index];

                  return CustomRecentTaskComponent(
                     taskData:  createTaskData
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget homeCardSimmer({bool? recentLoader}){
    return Card(
      color: Colors.white,
      shadowColor: kSkyBlueColor.withOpacity(0.5),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(
          children: [
            SkeletonView(
              isLoading: recentLoader,
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
                    isLoading: recentLoader,
                    borderRadius: BorderRadius.circular(8.sp),
                    child: SizedBox(
                      height: 14.sp,
                      width: 60.sp,
                    ),
                  ),

                  SizedBox(height: 5.sp),

                  SkeletonView(
                    isLoading: recentLoader,
                    borderRadius: BorderRadius.circular(8.sp),
                    child:SizedBox(
                      height: 16.sp,
                      width: 90.sp,
                    ),
                  ),
                ],
              ),
            ),

            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(5.sp),
              skeletonBody: SizedBox(
                height: 16.sp,
                width: 16.sp,
              ),
            ),

            SizedBox(
              width: 10.sp,
            ),

            // Time Working
            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(5.sp),
              skeletonBody: SizedBox(
                height: 14.sp,
                width: 70.sp,
              ),
            ),

            SizedBox(width: 10.sp),

            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(8.sp),
              skeletonBody: SizedBox(
                height: 24.sp,
                width: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
