import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';

class SubCategory {
  SubCategory(
      {required this.mainCategory,
      required this.subCatName,
      required this.image});

  SubCategory.fromJson(Map<String, Object?> json)
      : this(
          mainCategory: json['mainCategory']! as String,
          subCatName: json['subCatName']! as String,
          image: json['image']! as String,
        );

  final String mainCategory;
  final String subCatName;
  final String image;

  Map<String, Object?> toJson() {
    return {
      'mainCategory': mainCategory,
      'subCatName': subCatName,
      'image': image,
    };
  }
}

final FirebaseService _services = FirebaseService();

subCategoryCollection({selectedSubCat}) {
  return _services.subCategories
      .where('active', isEqualTo: true)
      .where('mainCategory', isEqualTo: selectedSubCat)
      .withConverter<SubCategory>(
        fromFirestore: (snapshot, _) => SubCategory.fromJson(snapshot.data()!),
        toFirestore: (category, _) => category.toJson(),
      );
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:my_multivender_ecommerce_app/firebase_service.dart';

// class Category {
//   Category({required this.catName, required this.image});

//   Category.fromJson(Map<String, Object?> json)
//       : this(
//           catName: json['catName']! as String,
//           image: json['image']! as String,
//         );

//   final String catName;
//   final String image;

//   Map<String, Object?> toJson() {
//     return {
//       'catName': catName,
//       'image': image,
//     };
//   }
// }

// final FirebaseService _services = FirebaseService();

// final categoryCollection = _services.categories
//     .where('active', isEqualTo: true)
//     .withConverter<Category>(
//       fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
//       toFirestore: (category, _) => category.toJson(),
//     );
