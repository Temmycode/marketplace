import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketplace/models/auth_result.dart';

class AuthService {
  const AuthService();
  static String error = '';
  get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;

  Future<AuthResult> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return AuthResult.success;
    } catch (e) {
      error = e.toString();
      log(e.toString());
      return AuthResult.failure;
    }
  }

  Future<AuthResult> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        log(e.toString());
        error = 'Invalid Password was enterd';
        return AuthResult.failure;
      } else if (e.code == 'user-not-found') {
        log(e.toString());
        error = 'This user does not exists';
        return AuthResult.failure;
      } else {
        log(e.toString());
        error = e.toString();
        return AuthResult.failure;
      }
    } catch (e) {
      error = e.toString();
      log(e.toString());
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists') {
        error = 'The email is already in use';
        log(e.toString());
      }
      return AuthResult.failure;
    } catch (e) {
      log(e.toString());
      return AuthResult.failure;
    }
  }
}
