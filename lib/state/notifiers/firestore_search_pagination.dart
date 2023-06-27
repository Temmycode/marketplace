import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/products_models.dart';
import 'package:marketplace/services/firestore_category_fetch_service.dart';
import 'package:marketplace/state/providers/pagination/firestore_category_provider.dart';

class FirestoreSearchPaginationNotifier extends ChangeNotifier {
  final Ref ref;
  final String productName;
  FirestoreSearchPaginationNotifier({
    required this.ref,
    required this.productName,
  });

  FirestoreQuery get firestoreSearch => ref.read(firestoreQueryProvider);

  final List<DocumentSnapshot> _searchDocuments = [];

  List<ProductModel> get searchProducts =>
      _searchDocuments.map((docs) => ProductModel.fromJson(docs)).toList();

  bool busy = false;
  bool loading = true;
  bool error = false;

  void init() async {
    try {
      _searchDocuments.addAll(
          await firestoreSearch.searchProducts(productName: productName));
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
      final documents = await firestoreSearch.searchProducts(
        productName: productName,
        lastDocument: _searchDocuments.last,
      );
      _searchDocuments.addAll(documents);
      loading = documents.isEmpty ? false : true;
    } catch (e) {
      log(e.toString());
      error = true;
      notifyListeners();
    }
    notifyListeners();
  }
}
