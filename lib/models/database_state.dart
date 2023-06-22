import 'package:flutter/material.dart' show immutable;
import 'auth_result.dart';

@immutable
class DatabaseState {
  final bool isLoading;
  final AuthResult? result;

  const DatabaseState({
    required this.isLoading,
    required this.result,
  });

  const DatabaseState.unkown()
      : isLoading = false,
        result = null;

  DatabaseState copyIsLoading(bool isLoading) => DatabaseState(
        isLoading: isLoading,
        result: result,
      );

  @override
  bool operator ==(covariant DatabaseState other) =>
      (isLoading == other.isLoading && result == other.result);

  @override
  int get hashCode => Object.hashAll(
        [
          isLoading,
          result,
        ],
      );
}
