import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osm_flutter/providers.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import 'app/lending/route/lending_route.dart';

class OmsApp extends StatelessWidget {
  const OmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MultiProvider(
              providers: [
                AppProviders.mainDashboardProvider,
                AppProviders.authProvider,
                AppProviders.homeProvider,
                AppProviders.lendingProvider,
                AppProviders.taskProvider,
                AppProviders.projectProvider
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'OSM',
                  routes: Routes().routes,
                  initialRoute: LendingRoute.route,
                  builder: (context, child) {
                    final data = MediaQuery.of(context);
                    return MediaQuery(
                        data: data.copyWith(
                          textScaler: const TextScaler.linear(1.0),
                        ),
                        child: child ?? const SizedBox.shrink());
                  }));
        },
      ),
    );
  }

  ThemeData appTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          centerTitle: true,
          color: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          foregroundColor: kBlackColor,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: kToolbarHeight,
        ),
        primarySwatch: primarySwatchColor,
        useMaterial3: true,
        fontFamily: "SourceSansPro");
  }
}
