import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/models/database_state.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

class UserDatabaseUploadNotifier extends StateNotifier<DatabaseState> {
  UserDatabaseUploadNotifier() : super(const DatabaseState.unkown());

  Future<void> uploadProfilePhoto({
    required File profilePhoto,
    required String userId,
  }) async {
    state = state.copyIsLoading(true);
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(FirebaseConstants.userCollection)
          .child(userId)
          .child(FirebaseConstants.storageProfilePictureChild);
      await storageRef.putFile(profilePhoto);
      final profilePhotoUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .update({FirebaseConstants.profilePhotoUpdateField: profilePhotoUrl});
      state = const DatabaseState(isLoading: false, result: AuthResult.success);
    } catch (e) {
      log(e.toString());
      state = const DatabaseState(isLoading: false, result: AuthResult.failure);
    }
  }

  Future<void> uploadNewBio({
    required String bio,
    required String userId,
  }) async {
    state = state.copyIsLoading(true);
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .update({FirebaseConstants.bioUpdateField: bio});
      state = const DatabaseState(isLoading: false, result: AuthResult.success);
    } catch (e) {
      log(e.toString());
      state = const DatabaseState(isLoading: false, result: AuthResult.failure);
    }
  }
}
