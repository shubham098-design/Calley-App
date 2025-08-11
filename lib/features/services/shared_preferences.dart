import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreference {
  var username='' ;
  Future<void> setLanguageCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
  }

  Future<String?> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language_code');
  }

  Future<void> set_id(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }

  Future<void> set_name(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  Future<String> get_name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');

    // Null ya empty hone par default value do
    if (name == null || name.isEmpty) {
      username = "xyz";
    } else {
      username = name;
    }
    return username; // hamesha String return karega
  }


}

