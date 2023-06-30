import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? cartId;
  final String? productId;
  final String? productPhoto;
  final int quantityToBuy;
  final double price;
  final String productDescription;
  final bool bought;

  const CartModel({
    required this.cartId,
    required this.productId,
    required this.productPhoto,
    required this.productDescription,
    required this.price,
    this.quantityToBuy = 0,
    this.bought = false,
  });

  // const CartModel.init()
  //     : cartId = null,
  //       productId = null,
  //       productPhoto = null,
  //       quantityToBuy = 1,
  //       price = null;
  //       bought = false;

  Map<String, dynamic> toJson() => {
        'cartId': cartId,
        'productId': productId,
        'productPhoto': productPhoto,
        'quantityToBuy': quantityToBuy,
        'bought': bought,
        'price': price,
        'productDescription': productDescription,
      };

  factory CartModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return CartModel(
      cartId: snap['cartId'],
      productId: snap['productId'],
      productPhoto: snap['productPhoto'],
      bought: snap['bought'],
      quantityToBuy: snap['quantityToBuy'],
      price: snap['price'],
      productDescription: snap['productDescription'],
    );
  }
}
