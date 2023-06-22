import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/models/auth_state.dart';
import 'package:marketplace/services/auth_service.dart';
import 'package:marketplace/services/firestore_user_upload_service.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  final _authService = const AuthService();
  AuthStateNotifier(this.ref) : super(const AuthState.unkown()) {
    if (_authService.isAlreadyLoggedIn) {
      state = AuthState(
        userId: _authService.userId,
        isLoading: false,
        isLoggedIn: true,
        result: AuthResult.success,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyIsLoading(true);
    final result = await _authService.logout();
    state = AuthState(
      userId: null,
      isLoading: false,
      isLoggedIn: false,
      result: result,
    );
  }

  Future<void> loginInWithEmailAndPassword(
      {required String email, required String password}) async {
    state = state.copyIsLoading(true);
    final result = await _authService.logInWithEmailAndPassword(
      email,
      password,
    );
    state = AuthState(
      userId: _authService.userId,
      isLoading: false,
      isLoggedIn: true,
      result: result,
    );
  }

  Future<void> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    state = state.copyIsLoading(true);
    final result = await _authService.signupWithEmailAndPassword(
      email,
      password,
    );
    if (result == AuthResult.success && _authService.userId != null) {
      final upload = await FirestoreUserUploadService().uploadUserToDatabase(
        email: email,
        userId: _authService.userId,
        username: username,
      );
      if (upload == false) {
        state = const AuthState.unkown();
      }
    }
    state = AuthState(
      userId: _authService.userId,
      isLoading: false,
      isLoggedIn: true,
      result: result,
    );
  }
}
