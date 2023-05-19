import 'dart:async';

import 'package:cpm/utils/secure_storage/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/login_service.dart';
import '../utils/constants_globals.dart';
import '../utils/secure_storage/secure_storage_key.dart';

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
    final List result = await LoginService().login(username, password);
    final bool authenticated = result[0] as bool;
    saveToken(authenticated, result[1] as String);
    state = AsyncValue<bool>.data(authenticated);

    return <String, dynamic>{'succeeded': authenticated, 'statusCode': result[2] as int};
  }

  void logout() {
    saveToken(false, '');
    state = const AsyncValue<bool>.data(false);
  }

  Future<void> saveToken(bool authenticated, String newToken) async {
    token = newToken;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Preferences.authenticated.name, authenticated);
    SecureStorage().write(SecureStorageKey.apiToken, newToken);
  }
}
