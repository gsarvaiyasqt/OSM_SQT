import 'package:flutter/material.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';


class OmsApp extends StatelessWidget {
  const OmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OSM',
            routes: Routes().routes,
            // initialRoute: LendingRoute.route,
            // theme: appTheme(context),

            builder: (context, child) {
              final data  = MediaQuery.of(context);
              return MediaQuery(
                  data: data.copyWith(textScaler: const TextScaler.linear(1.0),),
                  child: child ?? const SizedBox.shrink()
              ) ;
            },
          );
        },
      ),
    );
  }

  // ThemeData appTheme(BuildContext context){
  //   return ThemeData(
  //       appBarTheme: AppBarTheme.of(context).copyWith(
  //           centerTitle: true,
  //           color: Colors.transparent,
  //           systemOverlayStyle: const SystemUiOverlayStyle(
  //             statusBarColor: Colors.transparent,
  //             statusBarIconBrightness: Brightness.dark,
  //           ),
  //           foregroundColor: kBlackColor,
  //           surfaceTintColor: Colors.transparent,
  //           toolbarHeight: kToolbarHeight,
  //           titleTextStyle: TextStyle(
  //               color: kTextSecondaryColor,
  //               fontSize: 20.sp,
  //               fontWeight: FontWeight.w700,
  //               fontFamily: "NunitoSans"
  //           ),
  //           shape:  UnderlineInputBorder(
  //             borderSide: BorderSide(color: kTextSecondaryColor.withOpacity(0.30)),
  //           )
  //       ),
  //       primarySwatch: primarySwatchColor,
  //       useMaterial3: true,
  //       fontFamily: "NunitoSans"
  //   );
  // }
}
