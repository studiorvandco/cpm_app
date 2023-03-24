import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavorites {
  static const String FAVORITES_KEY = 'favorites_key';

  Future<void> setFavorites(List<String> ids) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(FAVORITES_KEY, ids);
  }

  Future<List<String>> getFavorites() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? result = sharedPreferences.getStringList(FAVORITES_KEY);
    if (result == null) {
      return <String>[];
    } else {
      return result;
    }
  }
}

class ModelFav extends ChangeNotifier {
  ModelFav() {
    _favoriteProjects = <String>[];
    _savedFavorites = MyFavorites();
    getFavorites();
  }

  late List<String> _favoriteProjects;
  late MyFavorites _savedFavorites;

  List<String> get favoriteProjects => _favoriteProjects;

  set favoriteProjects(List<String> favorites) {
    _favoriteProjects = favorites;
    _savedFavorites.setFavorites(favorites);
    notifyListeners();
  }

  Future<void> getFavorites() async {
    _favoriteProjects = await _savedFavorites.getFavorites();
    notifyListeners();
  }
}
