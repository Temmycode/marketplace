import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/products_models.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

final popularProductsProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) {
  final controller = StreamController<List<ProductModel>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseConstants.productsCollection)
      .where('stars', isGreaterThanOrEqualTo: 4)
      .snapshots()
      .listen(
    (snapshot) {
      final document = snapshot.docs;
      final products =
          document.map((doc) => ProductModel.fromJson(doc)).toList();
      controller.sink.add(products);
    },
  );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
