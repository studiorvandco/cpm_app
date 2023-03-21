import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../globals.dart';
import '../providers/authentication.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key, required this.onLogin});

  final void Function(String, String) onLogin;

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldMessengerKey,
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(bottom: 64.0),
                    child: Builder(
                      builder: (BuildContext context) {
                        if (Theme.of(context).brightness == Brightness.light) {
                          return Image.asset('assets/images/logo-camera.png',
                              filterQuality: FilterQuality.high, fit: BoxFit.fitWidth, width: 250);
                        } else {
                          return Image.asset('assets/images/logo-camera-blanc.png',
                              filterQuality: FilterQuality.high, fit: BoxFit.fitWidth, width: 250);
                        }
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: 300,
                    child: Focus(
                      canRequestFocus: false,
                      child: TextField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        controller: usernameController,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(), isDense: true, labelText: 'username'.tr()),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        submit();
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(), isDense: true, labelText: 'password'.tr()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ref.watch(authenticationProvider).when(data: (bool authenticated) {
                    return SizedBox(
                      width: 300,
                      height: 32,
                      child: FilledButton(
                        onPressed: submit,
                        child: Text('login'.tr()),
                      ),
                    );
                  }, error: (Object error, StackTrace stackTrace) {
                    return SizedBox(
                      width: 300,
                      child: FilledButton(
                        onPressed: submit,
                        child: Text('login'.tr()),
                      ),
                    );
                  }, loading: () {
                    return const SizedBox(height: 32, child: CircularProgressIndicator());
                  }),
                ),
                const Spacer()
              ],
            ),
          ),
        ));
  }

  void submit() {
    widget.onLogin(usernameController.text, passwordController.text);
  }
}
