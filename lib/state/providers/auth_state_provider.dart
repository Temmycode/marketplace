import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_state.dart';
import 'package:marketplace/state/notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref),
);
