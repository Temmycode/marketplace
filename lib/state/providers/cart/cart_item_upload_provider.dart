import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/database_state.dart';
import 'package:marketplace/state/notifiers/user_database_upload_notifier.dart';

final cartItemUploadProvider =
    StateNotifierProvider<UserDatabaseUploadNotifier, DatabaseState>(
  (_) => UserDatabaseUploadNotifier(),
);
