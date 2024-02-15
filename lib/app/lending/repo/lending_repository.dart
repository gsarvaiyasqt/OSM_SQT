import '../../../base/base.dart';
import '../../../services/secure_storage.dart';
import '../domain/ui_state/app_state_model.dart';
import '../domain/ui_state/set_add_state_model.dart';

abstract class ILendingRepository{
  Future<AppStateModel> getAppState();
  Future clearAppState();
  Future setAppStateForLogin(SetAddStateModel setAddStateModel);
}

class LendingRepository extends ILendingRepository {
  UserPrefs userPrefs = UserPrefs();
  SecureStorage secureStorage = SecureStorage();

  @override
  Future<AppStateModel> getAppState() async{
    final localUser = await userPrefs.getUser;

    return AppStateModel(isLogin: localUser.isLogin ?? false);
  }



  @override
  Future clearAppState() async{
    try {
      await userPrefs.clear();
      await userPrefs.removeLogin();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future setAppStateForLogin(setAddStateModel) async{
    var userId = setAddStateModel.userId.toString();
    var memberId = setAddStateModel.associationId.toString();
    await secureStorage.setToken(token: setAddStateModel.token ?? "");
    await secureStorage.setUserId(userID: userId);
    await secureStorage.setAssociationId(associationId: memberId);
    await userPrefs.setIsLogin(isLogin: true);
  }

}