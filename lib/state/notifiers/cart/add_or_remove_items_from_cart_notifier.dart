// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:marketplace/models/cart_model.dart';
// import 'package:marketplace/utils/constants/firebase_constants.dart';
// import 'package:uuid/uuid.dart';

// class AddOrRemoveItemsFromCartNotifier extends StateNotifier<CartModel> {
//   final int noOfItemsAvailable;
//   AddOrRemoveItemsFromCartNotifier({required this.noOfItemsAvailable}) : super(CartModel.init())
  
//   Future<void> addItemToCart({required String userId}) async {
//     final String cartId = const Uuid().v1();
//     cart
//     await FirebaseFirestore.instance.collection(FirebaseConstants.userCollection).doc(userId).collection(FirebaseConstants.cartCollection).doc(cartId).set(data)
//   }
// }
