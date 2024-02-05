import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage storage =  const FlutterSecureStorage();
  static String? userID;
  static String? associationID;
  static String? token;

  final String _tokenKey = "user_token";
  final String _userIdKey = "user_id";
  final String _associationIdKey = "association_id";

  ///  User Id
  Future<String?> getUserId() async {
    return await storage.read(key: _userIdKey);
  }

  setUserId({required String userID}) async {
    await storage.write(key: _userIdKey, value: userID);
  }

  Future<bool> get isUserAvailable async => await getUserId() != null;


  ///  member Id
  Future<String?> getAssociationId() async {
    return await storage.read(key: _associationIdKey);
  }

  setAssociationId({required String associationId}) async {
    await storage.write(key: _associationIdKey, value: associationId);
  }

  Future<bool> get isAssociationId async => await getAssociationId() != null;

  /// token
  Future<bool> get isTokenSet async => await getToken() != null;

  Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }
  setToken({required String token}) async {
    await storage.write(key: _tokenKey, value: token);
  }


  Future deleteAll() async {
    SecureStorage.userID = null;
    SecureStorage.token = null;
    SecureStorage.associationID = null;
    await storage.deleteAll();
  }

}