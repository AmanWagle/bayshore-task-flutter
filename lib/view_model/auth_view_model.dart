import 'package:flutter/material.dart';
import 'package:bayshore_task_frontend/repository/auth_repository.dart';
import 'package:bayshore_task_frontend/models/user_model.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository authRepository;

  String? _token;
  UserModel? _user;

  String? get token => _token;
  UserModel? get user => _user;

  AuthViewModel(this.authRepository);

  Future<void> login(String email, String password) async {
    try {
      final response = await authRepository.login(email, password);
      _token = response['token'];
      _user = UserModel.fromJson(response['user']);
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  // Register function
  Future<void> register(String email, String password) async {
    try {
      final response = await authRepository.register(email, password);
      _token = response['token'];
      _user = UserModel.fromJson(response['user']);
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> loadUserFromPreferences() async {
    try {
      final userData = await authRepository.getUserFromPreferences();
      _token = userData['token'];
      _user = UserModel.fromJson(userData['user']);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load user from preferences: $e');
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    _token = null;
    _user = null;
    notifyListeners();
  }
}
