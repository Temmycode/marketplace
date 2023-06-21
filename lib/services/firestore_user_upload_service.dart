import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:marketplace/models/user_model.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

class FirestoreUserUploadService {
  FirestoreUserUploadService();
  Future<bool> uploadUserToDatabase({
    required String userId,
    required String email,
    required String username,
  }) async {
    try {
      final user = UserModel(
        email: email,
        userId: userId,
        username: username,
      );
      FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc()
          .set(
            user.toJson(),
          );
      return true;
    } catch (_) {
      return false;
    }
  }
}
