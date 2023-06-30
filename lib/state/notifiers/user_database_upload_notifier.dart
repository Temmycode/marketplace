import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/models/cart_model.dart';
import 'package:marketplace/models/database_state.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';
import 'package:uuid/uuid.dart';

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

  // UPLOAD ITEM TO THE CART:
  Future<void> uploadItemToCart({
    required String userId,
    required String productPhoto,
    required double price,
    required String productDescription,
    required productId,
  }) async {
    state = state.copyIsLoading(true);
    try {
      final cartId = const Uuid().v4();
      final cartItem = CartModel(
        cartId: cartId,
        productId: productId,
        productPhoto: productPhoto,
        bought: false,
        quantityToBuy: 1,
        price: price,
        productDescription: productDescription,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.cartCollection)
          .doc(cartId)
          .set(
            cartItem.toJson(),
          );
      state = const DatabaseState(isLoading: false, result: AuthResult.success);
    } catch (e) {
      log(e.toString());
      state = const DatabaseState(isLoading: false, result: AuthResult.failure);
    }
  }
}
