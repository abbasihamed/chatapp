import 'package:shared_preferences/shared_preferences.dart';

class SharedController {
  saveDate({required String key, required String value}) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(key, value.trim());
  }

  getData({required String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }


}
