import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

part 'auth_remote_datasource.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
@injectable
abstract class AuthRemoteDatasource {
  @factoryMethod
  factory AuthRemoteDatasource(Dio dio) = _AuthRemoteDatasource;

  @POST(ApiConstants.loginEndpoint)
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.registerEndpoint)
  Future<UserModel> register(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.verifyOtpEndpoint)
  Future<UserModel> verifyOtp(@Body() Map<String, dynamic> body);
}
