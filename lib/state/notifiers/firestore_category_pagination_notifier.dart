import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/products_models.dart';
import 'package:marketplace/services/firestore_category_fetch_service.dart';
import 'package:marketplace/state/providers/pagination/firestore_category_provider.dart';

class FirestoreCategoryPaginatonNotifier extends ChangeNotifier {
  final Ref ref;
  final String category;
  FirestoreCategoryPaginatonNotifier({
    required this.ref,
    required this.category,
  });

  final List<DocumentSnapshot> _productsDocuments = [];

  List<ProductModel> get products => _productsDocuments
      .map(
        (product) => ProductModel.fromJson(product),
      )
      .toList();

  FirestoreQuery get fetch => ref.read(firestoreQueryProvider);

  bool busy = false;
  bool loading = true;
  bool error = false;

  void init() async {
    try {
      _productsDocuments.addAll(
        await fetch.fetchProducts(limit: 8, category: category),
      );
      busy = false;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      error = true;
      notifyListeners();
    }
  }

  void loadMore() async {
    busy = true;
    try {
      final moreProductsDocuments = await fetch.fetchProducts(
        limit: 8,
        category: category,
        lastDocument: _productsDocuments.last,
      );
      _productsDocuments.addAll(moreProductsDocuments);
      loading = moreProductsDocuments.isEmpty ? false : true;
    } catch (e) {
      log(e.toString());
      error = true;
      notifyListeners();
    }
    notifyListeners();
  }
}
