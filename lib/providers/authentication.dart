import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/login_service.dart';
import '../utils/constants_globals.dart';

part 'authentication.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  FutureOr<bool> build() {
    return supabase.auth.currentSession != null;
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncLoading<bool>();
    bool logged = await LoginService().login(email, password);
    state = AsyncValue<bool>.data(logged);

    return logged;
  }

  Future<void> logout() async {
    await LoginService().logout();
    state = const AsyncValue<bool>.data(false);
  }
}
