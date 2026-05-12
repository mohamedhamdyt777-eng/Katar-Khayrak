import 'package:injectable/injectable.dart';

import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

@injectable
class AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  AuthRepository(this._remoteDatasource, this._localDatasource);

  Future<UserModel> login(String email, String password) async {
    final user = await _remoteDatasource.login({
      'email': email,
      'password': password,
    });
    if (user.token != null) {
      await _localDatasource.saveToken(user.token!);
    }
    return user;
  }

  Future<UserModel> register(String name, String phone, String email, String password) async {
    final user = await _remoteDatasource.register({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });
    return user;
  }

  Future<void> logout() async {
    await _localDatasource.deleteToken();
  }

  Future<bool> isAuthenticated() async {
    final token = await _localDatasource.getToken();
    return token != null && token.isNotEmpty;
  }
}
