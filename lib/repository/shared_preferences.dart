import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    Set<List<String>> movieList = {};

    if (key == 'getAll') {
      var keys = prefs.getKeys();
      for (var element in keys) {
        movieList.add(prefs.getStringList(element)!);
      }
      return movieList;
    } else {
      return prefs.getStringList(key) ?? [''];
    }
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
