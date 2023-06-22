import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/models/user_model.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

class FirestoreUserUploadService {
  FirestoreUserUploadService();
  Future<bool> uploadUserToDatabase({
    required String userId,
    required String email,
    required String username,
    String? bio,
    File? profilePhoto,
  }) async {
    try {
      final user = UserModel(
        email: email,
        userId: userId,
        username: username,
        bio: bio,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .set(
            user.toJson(),
          );

      return true;
    } catch (_) {
      return false;
    }
  }
}
