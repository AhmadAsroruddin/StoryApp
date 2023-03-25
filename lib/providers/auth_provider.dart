import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../models/register.dart';

import '../routes/auth_repository.dart';

enum ResultState { loading, noData, hasData, error }

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;
  Register? registerResponse;

  AuthProvider({required this.apiService, required this.authRepository}) {
    print("Auth Provider");
  }

  bool isLoading = false;

  late ResultState _state;
  String _message = "";

  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> registrasi(String name, String email, String password) async {
    try {
      registerResponse = null;
      notifyListeners();

      _state = ResultState.loading;
      notifyListeners();
      registerResponse = await apiService.registerUser(email, name, password);
      notifyListeners();

      _state = ResultState.hasData;
      notifyListeners();
      return _message = 'Data berhasil dibuat';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  Future<dynamic> login(String email, String password) async {
    print("fired");
    try {
      _state = ResultState.loading;
      notifyListeners();
      final results = await apiService.login(email, password);
      print('di provider ${results.message}');

      if (!results.error) {
        await authRepository.login(results.loginResult.name,
            results.loginResult.token, results.loginResult.userId);
      }

      print(await authRepository.login(results.loginResult.name,
          results.loginResult.token, results.loginResult.userId));

      _state = ResultState.hasData;
      notifyListeners();
      return _message = results.message;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> ${e}';
    }
  }

  Future<dynamic> logout() async {
    print("fire");
    await authRepository.logout();
  }
}
