import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication/authentication.dart';
import '../utils/constants_globals.dart';
import '../widgets/custom_snack_bars.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  void _obscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  Future<void> _login() async {
    final logged = await ref.read(authenticationProvider.notifier).login(
          usernameController.text,
          passwordController.text,
        );
    if (!logged && scaffoldMessengerKey.currentContext != null && context.mounted) {
      ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!).showSnackBar(
        CustomSnackBars().getLoginSnackBar(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldMessengerKey,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Theme.of(context).brightness == Brightness.light
                      ? Image.asset(
                          Logos.cpmLight.value,
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.fitWidth,
                          width: 192,
                        )
                      : Image.asset(
                          Logos.cpmDark.value,
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.fitWidth,
                          width: 192,
                        ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 32.0)),
                  TextField(
                    controller: usernameController,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      hintText: 'Email',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(64.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(64.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                  TextField(
                    controller: passwordController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: obscurePassword,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      _login();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'password'.tr(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: IconButton(
                          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: _obscurePassword,
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(64.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(64.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 32.0)),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => _login(),
                      child: Text('authentication.login.upper'.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
