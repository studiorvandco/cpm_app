import 'package:supabase_flutter/supabase_flutter.dart';

import 'service.dart';

class AuthenticationService extends Service {
  bool isAuthenticated() {
    return supabase.auth.currentSession != null;
  }

  Future<bool> login(String email, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res.session != null;
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}