import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

class FirestoreQuery {
  Future<List<DocumentSnapshot>> fetchProducts(
      {required int limit,
      DocumentSnapshot? lastDocument,
      required String category}) async {
    var docRef = FirebaseFirestore.instance
        .collection(FirebaseConstants.productsCollection)
        .where('category', isEqualTo: category)
        .orderBy(
          'createdAt',
          descending: false,
        );

    if (lastDocument != null) {
      docRef = docRef.startAfterDocument(lastDocument);
    }

    return docRef.limit(limit).get().then((doc) => doc.docs);
  }

  Future<List<DocumentSnapshot>> searchProducts({
    required String productName,
    DocumentSnapshot? lastDocument,
  }) async {
    var docRef = FirebaseFirestore.instance
        .collection(FirebaseConstants.productsCollection)
        .orderBy('productName')
        .startAfter([productName]).endAt(['$productName\uf8ff']);

    if (lastDocument != null) {
      docRef = docRef.startAfterDocument(lastDocument);
    }

    return docRef.limit(8).get().then((doc) => doc.docs);
  }
}
