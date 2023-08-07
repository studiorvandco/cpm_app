import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/utils/platform_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../utils/constants_globals.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.light ? Logos.cpmLight.value : Logos.cpmDark.value,
              filterQuality: FilterQuality.medium,
              fit: BoxFit.fitWidth,
              width: 150,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
            SupaEmailAuth(
              redirectTo: PlatformIdentifier().isWeb ? null : 'rvandco.cpm://callback',
              onSignInComplete: (response) {
                ref.read(authenticationProvider.notifier).login();
              },
              onSignUpComplete: (response) {
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
