import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/notifiers/firestore_search_pagination.dart';

final firestoreSearchPaginationProvider =
    ChangeNotifierProvider.family<FirestoreSearchPaginationNotifier, String>(
  (
    ref,
    String productName,
  ) {
    final provider =
        FirestoreSearchPaginationNotifier(ref: ref, productName: productName);
    provider.init();
    return provider;
  },
);
