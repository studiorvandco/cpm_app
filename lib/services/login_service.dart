import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'api.dart';

class LoginService {
  final API api = API();

  Future<List> login(String username, String password) async {
    try {
      final Response response = await post(Uri.parse(api.login),
          headers: <String, String>{'accept': '*/*', 'content-type': 'application/json'},
          body: jsonEncode(<String, String>{'Username': username, 'Password': password}));

      if (response.statusCode == 200) {
        return [true, response.body, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return [false, response.body, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return [false, '', 408, 'error.timeout'.tr()];
    }
  }

  bool logout() {
    return false;
  }
}
