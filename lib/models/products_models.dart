import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
class ProductModel {
  final List images;
  final int noAvailable;
  final String userId;
  final String category;
  final String productName;
  final int stars;
  final double likePercentage;
  final int review;
  final int recommended;
  final String productDescription;
  final String specifications;
  final double price;
  final DateTime? createdAt;
  final int noSold;
  final bool promotion;
  final String thumbnail;

  const ProductModel({
    required this.images,
    required this.noAvailable,
    required this.userId,
    required this.category,
    required this.productName,
    required this.stars,
    required this.likePercentage,
    required this.review,
    required this.recommended,
    required this.productDescription,
    required this.specifications,
    required this.price,
    this.createdAt,
    required this.noSold,
    required this.promotion,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return ProductModel(
      images: snap['image'],
      noAvailable: snap['noAvailable'],
      userId: snap['userId'],
      category: snap['category'],
      productName: snap['productName'],
      stars: snap['stars'],
      likePercentage: snap['likePercentage'],
      review: snap['review'],
      recommended: snap['recommended'],
      productDescription: snap['productDescription'],
      specifications: snap['specifications'],
      price: snap['price'],
      // createdAt: snap['createdAt'],
      noSold: snap['noSold'],
      promotion: snap['promotion'],
      thumbnail: snap['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image': images,
        'noAvailable': noAvailable,
        'userId': userId,
        'category': category,
        'productName': productName,
        'stars': stars,
        'likePercentage': likePercentage,
        'review': review,
        'recommended': recommended,
        'productDescription': productDescription,
        'specification': specifications,
        'price': price,
        'createdAt': createdAt,
        'noSold': noSold,
        'promotion': promotion,
        'thumbnail': thumbnail,
      };

  @override
  String toString() =>
      '''
    ProductModel(image: $images, noAvailable: $noAvailable, userId: $userId, category: $category, productName: $productName,
    stars: $stars, likePercentage: $likePercentage, review: $review, recommended: $recommended, productDescription: $productDescription,
      specifications: $specifications, price: $price, noSold: $noSold, promotion: $promotion, thumbnail: $thumbnail)
''';

  @override
  bool operator ==(covariant ProductModel other) =>
      (productName == other.productName &&
          category == other.category &&
          productDescription == other.productDescription &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        userId,
        productName,
        category,
        productDescription,
      );
}
