import 'package:dio/dio.dart';
import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/app/auth/domain/response/send_otp_res_model.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';

abstract class IAuthUSeCases{
  Future<LoginResponseModel?> login({required String userName,required String password});
  Future forgotpassword({required String email});
  Future updatePassword({required String password,required String verifyPassword});
}


class AuthUseCases extends IAuthUSeCases{
  @override
  Future<LoginResponseModel?> login({required String userName, required String password}) async {

    final data = FormData.fromMap({
      "UserName": userName,
      "Password": password
    });

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.loginUrl,data: data));
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<SendOtpResModel> forgotpassword({required String email}) async {

    final data = FormData.fromMap({
      "UserName": email
    });

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.forgotpassword,data: data));
    
    return SendOtpResModel.fromJson(response);

    // return data;
  }

  @override
  Future updatePassword({required String password, required String verifyPassword}) async{

    final data = FormData.fromMap({
      "Password": password,
      "VerifyPassword": verifyPassword
    });

    final response = await WebService.instance.post(request: NetworkRequest(url:  ServerConfig.updatePasswordUrl,data: data));

    return SendOtpResModel.fromJson(response);
  }

}