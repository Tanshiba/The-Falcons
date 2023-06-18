import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';

class MainCategory {
  MainCategory({required this.category, required this.mainCategory});

  MainCategory.fromJson(Map<String, Object?> json)
      : this(
          category: json['category']! as String,
          mainCategory: json['mainCategory']! as String,
        );

  final String category;
  final String mainCategory;

  Map<String, Object?> toJson() {
    return {
      'category': category,
      'mainCategory': mainCategory,
    };
  }
}

final FirebaseService _services = FirebaseService();

mainCategoryCollection(selectedCat) {
  return _services.mainCategories
      .where('approved', isEqualTo: true)
      .where('category', isEqualTo: selectedCat)
      .withConverter<MainCategory>(
        fromFirestore: (snapshot, _) => MainCategory.fromJson(snapshot.data()!),
        toFirestore: (category, _) => category.toJson(),
      );
}
