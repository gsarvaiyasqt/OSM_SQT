
import 'package:flutter/material.dart';
import 'package:osm_flutter/app/project_tab/domain/dummy/project_list_model.dart';
import 'package:osm_flutter/app/project_tab/view_model/project_provider.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/base/view/base_components/custom_image_view.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../task_tab/domain/respones/get_user_and_project_response_model.dart';

class CustomProjectListComponent extends StatefulWidget {

  final ProjectListModel? projectData;

  const CustomProjectListComponent({super.key,this.projectData});

  @override
  State<CustomProjectListComponent> createState() => _CustomProjectListComponentState();
}

class _CustomProjectListComponentState extends State<CustomProjectListComponent> {


  @override
  Widget build(BuildContext context) {
    List<String>? techList = widget.projectData?.technologies?.split(",");

    final processValue = (widget.projectData?.closeTaskCount ?? 0) / (widget.projectData?.allTaskCount ?? 0) * 100;

    final userList = widget.projectData?.projectUserList;

    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(5.sp)
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 40.sp,
                  width: 40.sp,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: widget.projectData?.projectImg != "" ?
                      Image.network(widget.projectData?.projectImg ?? "",fit: BoxFit.cover,) :
                      Image.network("https://media.licdn.com/dms/image/C4E0BAQEt8JeuZLpvig/company-logo_200_200/0/1630629943515/softqube_technologies_logo?e=2147483647&v=beta&t=JOFqUaZI210vOaH2WCCff5o1dprh5rV3NA-iOjDM4gg",fit: BoxFit.cover,))),
              SizedBox(
                width: 9.sp,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.projectData?.projectName ?? "",
                        style: CustomTextStyle
                            .semiBoldFont18Style
                    ),
                    Row(
                      children: [

                        SizedBox(
                          height: 10.sp,
                          width: 10.sp,
                          child: ImageUtil.iconImageClass.calenderIcon,
                        ),

                        SizedBox(width: 5.sp,),

                        Text(
                          widget.projectData?.projectDate ?? "",
                          style: CustomTextStyle
                              .regularFont12Style.copyWith(color: kBlackColor.withOpacity(0.8)),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.sp,),

                    Wrap(
                      spacing: 8.sp,
                      runSpacing: 8.sp,
                      direction: Axis.horizontal,
                      children: List.generate(techList?.length ?? 0, (index) {

                        return techList?[index].isNotEmpty == true ?
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.sp,horizontal: 10.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.sp),
                              color: Color(0xffF2F2F2)
                          ),
                          child: Text(techList?[index] ?? "",style: CustomTextStyle.semiBoldFont16Style),
                        ) :
                            SizedBox.shrink();
                      }),
                    ),

                    SizedBox(height: 6.sp,),
                  ],
                ),
              ),

              Icon(Icons.more_horiz_outlined)
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Process",style: CustomTextStyle.semiBoldFont14Style,),

              Text("${processValue.toStringAsFixed(0)} %",style: CustomTextStyle.semiBoldFont14Style,)
            ],
          ),

          SizedBox(height: 5.sp,),

          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(5.sp),
            backgroundColor: kBlackColor.withOpacity(0.15),
            value: (widget.projectData?.closeTaskCount ?? 0) / (widget.projectData?.allTaskCount ?? 0),
            valueColor: AlwaysStoppedAnimation(kSecondaryColor),

          ),

          SizedBox(height: 15.sp,),

          Row(
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 5.sp),
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(6.sp)
                ),
                child: statusProject(projectStatus: widget.projectData?.status ?? ""),
              ),

              SizedBox(width: 10.sp,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 5.sp),
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(6.sp)
                ),
                child: Row(
                  children: [

                    SizedBox(
                        height: 12.sp,
                        width: 12.sp,
                        child: ImageUtil.iconImageClass.listIcon),

                    SizedBox(width: 6.sp,),

                    Text("${widget.projectData?.taskCount} Tasks",style: CustomTextStyle.boldFont14Style,),

                  ],
                ),
              ),

              Spacer(),


              Container(
                height: 35.sp,
                width: 120.sp,
                child: Stack(
                  children: buildImageStack(userList: userList),
                ),
              )
              // Stack(
              //   children: List.generate(userList?.length ?? 0, (index) {
              //     return Container(
              //       height: 35.sp,
              //       width: 35.sp,
              //       margin:  EdgeInsets.only(left: 25.sp * index),
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Colors.red.withOpacity(0.1 * index),
              //           border:Border.all(color: Colors.white,width: 2.sp
              //           )
              //       ),
              //       child: userList?.isNotEmpty == true ?
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(100),
              //           child: CustomImageView(
              //             uri: userList?[index].profilePic,
              //             placeholder:  Container(
              //                 alignment: Alignment.center,
              //                 color: kBlackColor.withOpacity(0.3),
              //                 child: ImageUtil.logo.appLogo
              //             ),
              //           )) :
              //       const SizedBox.shrink(),
              //     );
              //   }),
              // )

            ],
          ),

        ],
      ),
    );
  }

  List<Widget> buildImageStack({List<ProjectUser>? userList}) {
    List<Widget> stackChildren = [];

    // Display the first 4 images in a circular shape
    for (int i = 0; i < userList!.length && i < 3; i++) {
      stackChildren.add(
        Positioned(
          left: i * 20.0,
          child: Container(
            height: 35.sp,
            width: 35.sp,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:Border.all(color: Colors.white,width: 2.sp
                )
            ),
            child: userList.isNotEmpty == true ?
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CustomImageView(
                  uri: userList[i].profilePic,
                  placeholder:  Container(
                      alignment: Alignment.center,
                      color: kBlackColor.withOpacity(0.3),
                      child: ImageUtil.logo.appLogo
                  ),
                )) :
            const SizedBox.shrink(),
          ),
        ),
      );
    }

    // Display the count of remaining images on the last image
    if (userList.length > 3) {
      stackChildren.add(
        Positioned(
          left: 3 * 20.0,
          child: Container(
            height: 35.sp,
            width: 35.sp,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
                shape: BoxShape.circle,
                border:Border.all(color: Colors.white,width: 2.sp
                )
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                        '+${userList.length - 3}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
                        ),
            ),
        ),
      )
      );
    }

    return stackChildren;
  }


}
