import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/notifiers/firestore_category_pagination_notifier.dart';

final firestoreCategoryPaginationProvider =
    ChangeNotifierProvider.family<FirestoreCategoryPaginatonNotifier, String>(
        (ref, String category) {
  final provider =
      FirestoreCategoryPaginatonNotifier(ref: ref, category: category);
  provider.init();
  return provider;
});
