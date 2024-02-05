

import 'package:provider/provider.dart';

import 'app/tab/view_model/tab_bar_provider.dart';

class AppProviders{


  // Providers
  static get mainDashboardProvider => ChangeNotifierProvider(create: (context) => TabBarProvider());


}