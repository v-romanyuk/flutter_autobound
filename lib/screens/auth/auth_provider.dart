import 'package:Autobound/models/models.dart';
import 'package:Autobound/services/http/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? get token { return _token; }

  bool get isAuthenticated { return _token != null; }

  Future<String> login (LoginForm loginForm) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = (await httpService.post('/auth/login', data: loginForm.toJson())).data;
    _token = LoginResponse.fromJson(res).token;
    sharedPrefs.setString('Autobound_Token', _token!);
    notifyListeners();

    return Future.value(_token);
  }

  Future<bool> autoLogin () async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (!sharedPrefs.containsKey('Autobound_Token')) {
      return false;
    }
    _token = sharedPrefs.getString('Autobound_Token');
    notifyListeners();
    return true;
  }

  void logout () async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _token = null;
    sharedPrefs.clear();
  }
}
