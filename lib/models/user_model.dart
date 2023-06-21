import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:marketplace/utils/typedefs/userid_typedef.dart';

@immutable
class UserModel {
  final String email;
  final UserId userId;
  final String username;
  final String? bio;
  final String? profilePhoto;
  const UserModel({
    required this.email,
    required this.userId,
    required this.username,
    this.bio,
    this.profilePhoto,
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      email: snap['email'],
      userId: snap['userId'],
      username: snap['username'],
      bio: snap['bio'],
      profilePhoto: snap['profilePhoto'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'bio': bio,
        'profilePhoto': profilePhoto,
      };

  @override
  bool operator ==(covariant UserModel other) => (userId == other.userId &&
      username == other.username &&
      bio == other.bio &&
      profilePhoto == other.profilePhoto);

  @override
  int get hashCode => Object.hashAll(
        [
          username,
          userId,
          bio,
          profilePhoto,
        ],
      );
}
