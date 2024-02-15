import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

class CustomShowModalBottomSheetPopup {

  final String title;
  final String message;
  final String primaryBtnTxt;
  final String? secondaryBtnTxt;
  final Function? primaryAction;
  final bool primaryLoader;
  final Function? secondaryAction;

  CustomShowModalBottomSheetPopup(BuildContext context,  {this.primaryLoader = false,required this.title,required this.message,required this.primaryBtnTxt, this.secondaryBtnTxt, this.primaryAction, this.secondaryAction}){
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(context: context, backgroundColor: Colors.white,shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true, builder: (context) {
          return  SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon(Icons.close,color: Colors.transparent,),
                      Expanded(
                        child: Text(title,style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),textAlign: TextAlign.center,),
                      ),
                      // IconButton(icon: Icon(Icons.close), onPressed: (){
                      //   Navigator.of(context).pop();
                      // })
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 500 ? 500 : size.width * 0.9,minHeight: 10,maxHeight: size.height * 0.5),
                    child: SingleChildScrollView(
                      child: Text(message,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 16
                        ),textAlign: TextAlign.center,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    children: [
                      if(secondaryBtnTxt != null)
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                                if(secondaryAction != null ){
                                  secondaryAction!();
                                }
                              },
                              child: Text(secondaryBtnTxt ?? "",style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                      if(secondaryBtnTxt != null)
                        const SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                              if(primaryAction != null){
                                primaryAction!();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(primaryBtnTxt,style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                )),

                                SizedBox(width: 10.sp),

                                if(primaryLoader)
                                SizedBox(
                                  height: 25.sp,width: 25.sp,
                                  child: CircularProgressIndicator(
                                    color: kWhiteColor,
                                    strokeWidth: 1,

                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}