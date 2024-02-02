part of base;



class UserPrefs{

  // Set Local Data here
  Future setAuthLocalData({required LocalUser user}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IS_USER_LOGIN', user.isLogin ?? false);
  }
  Future setIsLogin({required bool isLogin}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IS_USER_LOGIN', isLogin);
  }

  Future setIsGuest({required bool isGuest}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IS_GUEST', isGuest);
  }
  // Clear Local here
  Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

   removeLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("IS_USER_LOGIN");
  }

  // Get User here
  Future<LocalUser> get getUser => _getUser();

  Future<LocalUser> _getUser() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool('IS_USER_LOGIN') ?? false;

    return LocalUser(isLogin: isLogin,);
  }

  // Get is login here
  Future<bool> get isUserLogin => _isUserLogin();

  Future<bool> _isUserLogin() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool('IS_USER_LOGIN') ?? false;

    return isLogin;
  }

  // Get is IsGuest here
  Future<bool> get isGuest => _isGuest();

  Future<bool> _isGuest() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isGuest = prefs.getBool('IS_GUEST') ?? false;

    return isGuest;
  }
}


class LocalUser{
  final bool? isLogin;

  LocalUser(
      {this.isLogin});

}

