import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';

class Category {
  Category({required this.catName, required this.image});

  Category.fromJson(Map<String, Object?> json)
      : this(
          catName: json['catName']! as String,
          image: json['image']! as String,
        );

  final String catName;
  final String image;

  Map<String, Object?> toJson() {
    return {
      'catName': catName,
      'image': image,
    };
  }
}

final FirebaseService _services = FirebaseService();

final categoryCollection = _services.categories
    .where('active', isEqualTo: true)
    .withConverter<Category>(
      fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
      toFirestore: (category, _) => category.toJson(),
    );
