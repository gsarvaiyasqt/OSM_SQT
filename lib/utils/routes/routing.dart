part of utils;

class Routes {
  Map<String, WidgetBuilder> routes = {
    LendingRoute.route:(context) => LendingRoute.child,
    AuthRoute.splashRoute:(context) => AuthRoute.splashChild,
    AuthRoute.loginRoute:(context) => AuthRoute.loginChild,
    AuthRoute.forgotRoute:(context) => AuthRoute.forgotChild,
    AuthRoute.otpRoute:(context) => AuthRoute.otpChild,
    AuthRoute.changePasswordRoute:(context) => AuthRoute.changePasswordChild,
    TabRoute.route : (context) => TabRoute.child,
    TaskRoute.createTaskRoute : (context) => TaskRoute.createTaskChild,
    HomeRoute.route : (context) => HomeRoute.child,
    SettingRoute.route : (context) => SettingRoute.child,
    TaskRoute.route : (context) => TaskRoute.child,
    ProjectRoute.route : (context) => ProjectRoute.child,
    TaskRoute.updateTaskRoute : (context) => TaskRoute.updateTaskChild,

  };
}