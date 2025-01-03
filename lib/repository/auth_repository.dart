import 'package:bayshore_task_frontend/services/api_service.dart';
import 'package:bayshore_task_frontend/services/shared_preferences_service.dart';

class AuthRepository {
  final ApiService apiService;
  final SharedPreferencesService sharedPreferencesService;

  AuthRepository(this.apiService, this.sharedPreferencesService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await apiService.post('/users/login', {
      'email': email,
      'password': password,
    });

    if (response != null && response['token'] != null) {
      await sharedPreferencesService.setToken(response['token']);
      await sharedPreferencesService.setUser(response['user']);
      return response;
    } else {
      throw Exception('Failed to login');
    }
  }

  // Register function similar to login
  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await apiService.post('/users/register', {
      'email': email,
      'password': password,
    });

    if (response != null && response['token'] != null) {
      await sharedPreferencesService.setToken(response['token']);
      await sharedPreferencesService.setUser(response['user']);
      return response;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<Map<String, dynamic>> getUserFromPreferences() async {
    final user = await sharedPreferencesService.getUser();
    final token = await sharedPreferencesService.getToken();

    if (token != null && user != null) {
      return {'token': token, 'user': user};
    }

    throw Exception('No user found in SharedPreferences');
  }

  Future<void> logout() async {
    await sharedPreferencesService.clear();
  }
}
