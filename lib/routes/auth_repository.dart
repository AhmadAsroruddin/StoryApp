import 'package:shared_preferences/shared_preferences.dart';


class AuthRepository {
  final String stateKey = "isLoggin";

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return pref.getBool(stateKey) ?? false;
  }

  Future<bool> login(String userName, String token, String userId) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("userName", userName);
    pref.setString("token", token);
    pref.setString("userId", userId);

    return pref.setBool(stateKey, true);
  }

  Future<bool> logout()async{
     final pref = await SharedPreferences.getInstance();
    pref.setString("userName", "");
    pref.setString("token", "");
    pref.setString("userId", "");

    return pref.setBool(stateKey, false);
  }
}
