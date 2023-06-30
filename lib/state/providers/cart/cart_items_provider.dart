import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/cart_model.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

final cartItemsProvider = StreamProvider.family
    .autoDispose<List<CartModel>, String>((ref, String userId) {
  final controller = StreamController<List<CartModel>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseConstants.userCollection)
      .doc(userId)
      .collection(FirebaseConstants.cartCollection)
      .where('bought', isEqualTo: false)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final cartItems = documents
        .map(
          (snapshot) => CartModel.fromJson(snapshot),
        )
        .toList();
    controller.sink.add(cartItems);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
