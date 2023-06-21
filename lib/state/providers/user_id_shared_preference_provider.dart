import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/notifiers/user_id_notifier.dart';
import 'package:marketplace/utils/typedefs/userid_typedef.dart';

final userIdSharedPreferenceProvider =
    StateNotifierProvider<UserIdNotifier, UserId?>(
  (ref) => UserIdNotifier(),
);
