import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/extensions/string_validators.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/snack_bar/custom_snack_bar.dart';
import '../../utils/snack_bar/snack_bar_manager.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  void _obscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final logged = await ref.read(authenticationProvider.notifier).login(
          usernameController.text,
          passwordController.text,
        );

    if (logged && context.mounted) {
      context.replaceNamed(RouterRoute.projects.name);
    } else {
      SnackBarManager().show(getErrorSnackBar('Login failed.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 512,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                          Image.asset(
                            Asset.cpm.path,
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fitWidth,
                            width: 192,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 32.0)),
                          TextFormField(
                            controller: usernameController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field';
                              } else if (!value.isValidEmail()) {
                                return 'Invalid email';
                              }

                              return null;
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                          TextFormField(
                            controller: passwordController,
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: obscurePassword,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              _login();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field';
                              }

                              return null;
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
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
                          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}