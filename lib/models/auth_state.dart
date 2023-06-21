import 'package:flutter/material.dart' show immutable;
import 'package:marketplace/utils/typedefs/userid_typedef.dart';
import 'auth_result.dart';

@immutable
class AuthState {
  final UserId? userId;
  final bool isLoading;
  final bool isLoggedIn;
  final AuthResult? result;

  const AuthState({
    required this.userId,
    required this.isLoading,
    required this.isLoggedIn,
    required this.result,
  });

  const AuthState.unkown()
      : isLoading = false,
        isLoggedIn = false,
        result = null,
        userId = null;

  AuthState copyIsLoading(bool isLoading) => AuthState(
        userId: userId,
        isLoading: isLoading,
        isLoggedIn: isLoggedIn,
        result: result,
      );

  AuthState copyIsLoggedIn(bool isLoggedIn) => AuthState(
        userId: userId,
        isLoading: isLoading,
        isLoggedIn: isLoggedIn,
        result: result,
      );

  @override
  bool operator ==(covariant AuthState other) => (userId == other.userId &&
      isLoading == other.isLoading &&
      isLoggedIn == other.isLoggedIn &&
      result == other.result);

  @override
  int get hashCode => Object.hashAll(
        [
          isLoading,
          isLoggedIn,
          userId,
          result,
        ],
      );
}
