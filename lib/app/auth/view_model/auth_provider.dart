
import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/app/auth/domain/response/send_otp_res_model.dart';
import 'package:osm_flutter/app/auth/repository/auth_repository.dart';
import 'package:osm_flutter/base/base.dart';

abstract class IAuthProvider{

  Future login({required String userName,required String password});
  Future sendOtpWithoutAuth({required String email});
  Future updatePassword({required String password,required String verifyPassword});
}

class AuthProvider extends BaseNotifier implements IAuthProvider{

  final IAuthRepository? authRepository;

  AuthProvider({this.authRepository}){

    _loginResponse = AppResponse();
    _sendOtpWithoutAuthResponse = AppResponse();
    _updatePasswordResponse = AppResponse();
  }

  late AppResponse<LoginResponseModel> _loginResponse;
  AppResponse<LoginResponseModel> get loginResponse => _loginResponse;

  late AppResponse<SendOtpResModel> _sendOtpWithoutAuthResponse;
  AppResponse<SendOtpResModel> get sendOtpWithoutAuthResponse => _sendOtpWithoutAuthResponse;

  late AppResponse<SendOtpResModel> _updatePasswordResponse;
  AppResponse<SendOtpResModel> get updatePasswordResponse => _updatePasswordResponse;

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

  @override
  Future sendOtpWithoutAuth({required String email}) async {
    resIsLoading(_sendOtpWithoutAuthResponse);

    final res = await authRepository?.sendOtpWithoutAuth(email: email);

    try {
      if(res?.statusCode != 1){
            throw res?.message ?? "";
          }else{
            resIsSuccess(_sendOtpWithoutAuthResponse, res);
          }
    } catch (e) {
      resIsFailed(_sendOtpWithoutAuthResponse, e);
      rethrow;
    }
  }

  @override
  Future updatePassword({required String password, required String verifyPassword}) async {
    resIsLoading(_updatePasswordResponse);

    try {
      final res = await authRepository?.updatePassword(password: password, verifyPassword: verifyPassword);

      if(res?.statusCode != 1){
            throw res?.message ?? "";
          }else{
            throw resIsSuccess(_updatePasswordResponse, res);
          }
    } catch (e) {
      resIsFailed(_updatePasswordResponse, e);
      rethrow;
    }
  }
}