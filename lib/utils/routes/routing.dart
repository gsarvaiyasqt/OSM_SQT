part of utils;

class Routes {
  Map<String, WidgetBuilder> routes = {
    AuthRoute.splashRoute:(context) => AuthRoute.splashChild,
    AuthRoute.loginRoute:(context) => AuthRoute.loginChild,
    AuthRoute.forgotRoute:(context) => AuthRoute.forgotChild,
    AuthRoute.otpRoute:(context) => AuthRoute.otpChild,
    AuthRoute.changePasswordRoute:(context) => AuthRoute.changePasswordChild
    // LendingRoute.route:(context) => LendingRoute.child,
  };
}