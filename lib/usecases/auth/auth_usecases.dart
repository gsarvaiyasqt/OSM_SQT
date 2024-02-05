import 'package:dio/dio.dart';
import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';

abstract class IAuthUSeCases{
  Future<LoginResponseModel?> login({required String userName,required String password});
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

}