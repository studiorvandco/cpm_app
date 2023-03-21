import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/login.dart';

part 'authentication.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    state = const AsyncLoading<bool>();
    final List<dynamic> result = await LoginService().login(username, password);
    state = AsyncValue<bool>.data(result[0] as bool);
    return <String, dynamic>{'succeeded': result[0] as bool, 'statusCode': result[2] as int};
  }

  Future<void> logout() async {
    state = const AsyncValue<bool>.data(false);
  }
}
