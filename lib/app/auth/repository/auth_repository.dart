import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/usecases/auth/auth_usecases.dart';

abstract class IAuthRepository{
  Future<LoginResponseModel?> login({required String userName,required String password});
}

class AuthRepository extends IAuthRepository{

  final IAuthUSeCases? authUSeCases;

  AuthRepository({this.authUSeCases});

  @override
  Future<LoginResponseModel?> login({required String userName, required String password}) async {

    return await authUSeCases?.login(userName: userName, password: password);
  }
}