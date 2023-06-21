import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/notifiers/is_logged_in_notifier.dart';
import 'package:marketplace/utils/typedefs/is_logged_in_typedef.dart';

final isLoggedInProvider =
    StateNotifierProvider<IsLoggedInNotifier, IsLoggedIn>(
  (_) => IsLoggedInNotifier(),
);
