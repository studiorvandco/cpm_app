import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/login.dart';
import '../utils/constants_globals.dart';

part 'authentication.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  FutureOr<bool> build() {
    return get();
  }

  Future<bool> get() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(Preferences.authenticated.name) ?? false;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    state = const AsyncLoading<bool>();
    final List<dynamic> result = await LoginService().login(username, password);
    final bool authenticated = result[0] as bool;
    save(authenticated, result[1] as String);
    state = AsyncValue<bool>.data(authenticated);
    return <String, dynamic>{'succeeded': authenticated, 'statusCode': result[2] as int};
  }

  Future<void> logout() async {
    save(false, '');
    state = const AsyncValue<bool>.data(false);
  }

  Future<void> save(bool authenticated, String newToken) async {
    token = newToken;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Preferences.authenticated.name, authenticated);
    preferences.setString(Preferences.token.name, token);
  }
}
