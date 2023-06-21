import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/utils/application_keys/shared_preference_keys.dart';
import 'package:marketplace/utils/typedefs/is_logged_in_typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsLoggedInNotifier extends StateNotifier<IsLoggedIn> {
  IsLoggedInNotifier() : super(false) {
    getIsLoggedIn().then((isloggedin) => state = isloggedin);
  }

  Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.isLoggedInKey) ?? false;
  }

  Future<void> setIsLoggedInSharedPreference(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    state = isLoggedIn;
    prefs.setBool(SharedPreferenceKeys.isLoggedInKey, state);
  }

  clearIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferenceKeys.isLoggedInKey);
    state = false;
  }
}
