import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/utils/application_keys/shared_preference_keys.dart';
import 'package:marketplace/utils/typedefs/userid_typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIdNotifier extends StateNotifier<UserId?> {
  UserIdNotifier() : super(null) {
    getUserId().then((userId) => state = userId);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceKeys.userIdKey);
  }

  setUserId(String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    state = userId;
    prefs.setString(SharedPreferenceKeys.userIdKey, state!);
  }

  clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferenceKeys.userIdKey);
    state = null;
  }
}
