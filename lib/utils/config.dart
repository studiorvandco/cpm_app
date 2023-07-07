import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Config {
  late final dynamic config;

  static Config? _instance;

  Config._(String yaml) {
    config = loadYaml(yaml);
  }

  static dynamic get(String key) {
    if (_instance == null) {
      throw Exception('Configuration not yet initialized');
    }

    return _instance!._get(key);
  }

  static Future<void> init() async {
    final String yaml = await rootBundle.loadString('assets/config/config.yaml');
    _instance = Config._(yaml);
  }

  dynamic _get(String key) {
    return config[key];
  }
}
