import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/utils/typedefs/is_loading_typedef.dart';

final isLoadingProvider = Provider<IsLoading>((ref) {
  final auth = ref.watch(authStateProvider).isLoading;
  return auth;
});
