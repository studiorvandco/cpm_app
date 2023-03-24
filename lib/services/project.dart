import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/project.dart';
import '../utils/constants_globals.dart';

class ProjectService {
  Future<List<dynamic>> getAll() async {
    try {
      final Response response = await get(Uri.parse(api.projects),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      final List<dynamic> projectsJson = json.decode(response.body) as List<dynamic>;
      final List<Project> projects = projectsJson.map((project) => Project.fromJson(project)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[true, projects, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ProjectService getAll request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, <Project>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, <Project>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> add(Project project) async {
    try {
      final Response response = await post(Uri.parse(api.projects),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(project));

      if (response.statusCode == 201) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ProjectService add request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> edit(Project project) async {
    try {
      final Response response = await put(Uri.parse('${api.projects}/${project.id}'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(project));

      if (response.statusCode == 204) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ProjectService edit request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> delete(String projectID) async {
    try {
      final Response response = await http.delete(Uri.parse('${api.projects}/$projectID'), headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
        api.authorization: api.bearer + token
      });

      if (response.statusCode == 204) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ProjectService delete request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }
}
