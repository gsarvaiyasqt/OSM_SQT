import '../../../base/base.dart';
import 'package:flutter/material.dart';
import '../../../services/secure_storage.dart';
import '../../../utils/utils.dart';
import '../repo/lending_repository.dart';
import '../domain/ui_state/app_state_model.dart';

import '../domain/ui_state/set_add_state_model.dart';

import '../../../base/view/base_components/custom_button.dart';

abstract class ILendingProvider {
  Future setAppState(SetAddStateModel setAddStateModel);
  Future getAppState();
  Future clearAppState();
}


class LendingProvider extends BaseNotifier implements ILendingProvider {
  late final ILendingRepository lendingRepository;
  AppStateModel? appStateModel;
  String? userId;
  String? associationId;
  String? token;
  String? email;
  bool? isLogin;

  bool isUnderMaintenance = false;
  bool isMajorUpdate = false;
  bool isMinorUpdate = false;

  bool? isLocalAuthEnabled;
  bool? isLocalAuth;

  LendingProvider({required this.lendingRepository}) {
    initial();
  }
  bool isUserIDLoading = true;
  SecureStorage secureStorage = SecureStorage();

  initial() async {
    await getAppState();
  }

  @override
  Future getAppState() async{
    try {
      appStateModel = await lendingRepository.getAppState();

      isLogin = appStateModel?.isLogin ?? false;

    } catch (e) {

      appStateModel = AppStateModel(isLogin: false);

    } finally {
      if(userId == null){

        await getLocalStorageData();

      }
      notifyListeners();
    }
  }

  setIsLocalEnabled({required bool isOn}) {
    isLocalAuthEnabled = isOn;
    isLocalAuth = true;
    notifyListeners();

  }

  setIsLocalAuthenticated() {
    isLocalAuth = true;
    notifyListeners();
  }

  getLocalStorageData() async{
    try {
      if(isLogin == true) {
        isUserIDLoading = true;
        SecureStorage.token = await secureStorage.getToken();
        SecureStorage.userID = await secureStorage.getUserId();
        SecureStorage.associationID = await secureStorage.getAssociationId();
        userId = SecureStorage.userID;
        token = SecureStorage.token;
        associationId = SecureStorage.associationID;
      }
    } catch (e) {
      print(e);
    } finally {
      isUserIDLoading = false;
    }
    notifyListeners();
  }

  @override
  Future clearAppState() async{
    appStateModel = AppStateModel(isLogin: false);
    associationId = null;
    userId = null;
    token = null;
    isLogin = false;
    notifyListeners();
    await lendingRepository.clearAppState();
    notifyListeners();
  }

  @override
  Future setAppState(SetAddStateModel setAddStateModel) async{
    await lendingRepository.setAppStateForLogin(setAddStateModel);
    await getAppState();
    notifyListeners();
  }



}


class ErrorBuilder extends StatelessWidget {
  const ErrorBuilder({Key? key, required this.message, required this.onRetry, this.isLoading}) : super(key: key);

  final String message;
  final Function() onRetry;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: ImageUtil.logo.appLogo),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message,style: CustomTextStyle.regularFont16Style),
                    SizedBox(
                        height: 25.sp
                    ),
                    CustomButton(btnText: "Retry",onTap: () {
                      onRetry();
                    },isLoading: isLoading),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
