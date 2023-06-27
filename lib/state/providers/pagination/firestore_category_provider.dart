import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/services/firestore_category_fetch_service.dart';

final firestoreQueryProvider = Provider<FirestoreQuery>(
  (ref) => FirestoreQuery(),
);
