
import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/app/auth/repository/auth_repository.dart';
import 'package:osm_flutter/base/base.dart';

abstract class IAuthProvider{

  Future login({required String userName,required String password});
}

class AuthProvider extends BaseNotifier implements IAuthProvider{

  final IAuthRepository? authRepository;

  AuthProvider({this.authRepository}){

    _loginResponse = AppResponse();
  }

  late AppResponse<LoginResponseModel> _loginResponse;
  AppResponse<LoginResponseModel> get loginResponse => _loginResponse;

  @override
  Future login({required String userName, required String password}) async {

    resIsLoading(_loginResponse);

    try {
      final res = await authRepository?.login(userName: userName, password: password);

      if(res?.statusCode != 1){
            throw res?.message ?? "";
          }else{
            resIsSuccess(_loginResponse, res);
          }
    } catch (e) {
      resIsFailed(_loginResponse, e);
      rethrow;
    }
  }
}