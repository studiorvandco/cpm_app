import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/constants_globals.dart';

class LoginService {
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
