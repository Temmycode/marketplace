import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/products_models.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

final categoryProvider = StreamProvider.family
    .autoDispose<List<ProductModel>, String>((ref, String category) {
  final controller = StreamController<List<ProductModel>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseConstants.productsCollection)
      .where('category', isEqualTo: category)
      .limit(6)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final products = documents
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map(
          (doc) => ProductModel.fromJson(doc),
        )
        .toList();
    controller.sink.add(products);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
