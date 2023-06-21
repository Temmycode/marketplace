import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/user_model.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/utils/constants/firebase_constants.dart';

final userProfileProvider = StreamProvider.autoDispose<UserModel>(
  (ref) {
    final userId = ref.read(userIdSharedPreferenceProvider);
    final controller = StreamController<UserModel>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseConstants.userId)
        .where(FirebaseConstants.userId, isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      final doc = snapshot.docs.first;
      final user = UserModel.fromJson(doc);
      controller.add(user);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
