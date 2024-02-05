part of utils;

class Routes {
  Map<String, WidgetBuilder> routes = {

    TabRoute.route : (context) => TabRoute.child,
    HomeRoute.route : (context) => HomeRoute.child,
    SettingRoute.route : (context) => SettingRoute.child,
    TaskRoute.route : (context) => TaskRoute.child,
    ProjectRoute.route : (context) => ProjectRoute.child,

  };
}