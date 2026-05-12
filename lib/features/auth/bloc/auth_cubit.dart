import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(const AuthState.initial());

  Future<void> checkAuthStatus() async {
    try {
      final isAuth = await _repository.isAuthenticated();
      if (isAuth) {
        // Technically we might want to fetch user details, but we'll mock it for now
        emit(const AuthState.authenticated(UserModel(id: '1', name: 'User', phone: '', email: '')));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    try {
      // Mock network delay and successful login
      await Future.delayed(const Duration(seconds: 1));
      
      // Basic mock check to see if logging in as an organization
      final isOrg = email.toLowerCase().contains('org') || email.toLowerCase().contains('misr');
      final displayName = isOrg ? 'Misr El Kheir' : 'Mohamed Hamdy';
      
      emit(AuthState.authenticated(UserModel(
        id: '1', 
        name: displayName, 
        phone: '01012345678', 
        email: email, 
        token: 'mock_jwt_token',
      )));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(const AuthState.loading());
    try {
      // Mock network delay and successful registration
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthState.authenticated(UserModel(
        id: '1', 
        name: name, 
        phone: '01012345678', 
        email: email, 
        token: 'mock_jwt_token',
      )));
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(const AuthState.unauthenticated());
  }
}
