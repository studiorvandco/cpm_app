import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/member.dart';
import '../utils/constants_globals.dart';

class MemberService {
  Future<List> getMembers() async {
    try {
      final Response response = await get(Uri.parse(api.members),
        headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token},);

      if (response.statusCode == 200) {
        final List membersJson = json.decode(response.body) as List;
        final List<Member> members = membersJson.map((member) => Member.fromJson(member)).toList();

        return [true, members, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());

        return [false, <Member>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, <Member>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List> addMember(Member member) async {
    try {
      final Response response = await post(Uri.parse(api.members),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(member),);

      if (response.statusCode == 201) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> editMember(Member member) async {
    try {
      final Response response = await put(Uri.parse('${api.members}/${member.id}'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(member),);

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> deleteMember(String id) async {
    try {
      final Response response = await delete(Uri.parse('${api.members}/$id'), headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
        api.authorization: api.bearer + token,
      });

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }
}
