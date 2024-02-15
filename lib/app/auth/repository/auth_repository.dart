import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/app/auth/domain/response/send_otp_res_model.dart';
import 'package:osm_flutter/usecases/auth/auth_usecases.dart';

abstract class IAuthRepository{
  Future<LoginResponseModel?> login({required String userName,required String password});
  Future<SendOtpResModel> sendOtpWithoutAuth({required String email});
  Future<SendOtpResModel> updatePassword({required String password,required String verifyPassword});
}

class AuthRepository extends IAuthRepository{

  final IAuthUSeCases? authUSeCases;

  AuthRepository({this.authUSeCases});

  @override
  Future<LoginResponseModel?> login({required String userName, required String password}) async {

    return await authUSeCases?.login(userName: userName, password: password);
  }

  @override
  Future<SendOtpResModel> sendOtpWithoutAuth({required String email}) async {

    return await authUSeCases?.forgotpassword(email: email);
  }

  @override
  Future<SendOtpResModel> updatePassword({required String password, required String verifyPassword}) async {

    return await authUSeCases?.updatePassword(password: password, verifyPassword: verifyPassword);
  }
}