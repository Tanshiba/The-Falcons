import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    this.productName,
    this.regularPrice,
    this.salesPrice,
    this.taxStatus,
    // this.taxValue,
    this.category,
    this.mainCategory, 
    this.subCatName,
    this.description,
    this.scheduleDate,
    this.sku,
    this.manageInventory,
    this.soh,
    this.reOrderLavel,
    this.chargeShipping,
    this.shippingCharge,
    this.brand,
    this.sizeList,
    this.otherdetails,
    this.unit,
    this.imageUrls,
    this.seller,
    this.approved,
    this.productId
  });

  Product.fromJson(Map<String, Object?>json)
      : this(
          productName: json['productName'] as String,
          regularPrice: json['regularPrice'] as int,
          salesPrice: json['salesPrice'] == null ? null: json['salesPrice'] as int,
          taxStatus: json['taxStatus']== null ? null: json['taxStatus']  as String,
          // taxValue: json['taxValue'] == null ? null: json['taxValue'] as double,
          category: json['category'] as String,
          mainCategory: json['mainCategory'] == null ? null: json['mainCategory'] as String,
          subCatName: json['subCatName'] == null ? null: json['subCatName'] as String,
          description: json['description'] == null ? null: json['description'] as String,
          scheduleDate: json['scheduleDate'] == null ? null: json['scheduleDate'] as Timestamp,
          sku: json['sku'] == null ? null: json['sku'] as String,
          manageInventory: json['manageInventory'] == null ? null: json['manageInventory'] as bool,
          soh: json['soh'] == null ? null: json['soh'] as int,
          reOrderLavel: json['reOrderLavel'] == null ? null: json['reOrderLavel'] as int,
          chargeShipping: json['chargeShipping'] == null ? null: json['chargeShipping'] as bool,
          shippingCharge: json['shippingCharge'] == null ? null: json['shippingCharge'] as int,
          brand: json['brand'] == null ? null: json['brand'] as String,
          sizeList: json['sizeList'] == null ? null: json['sizeList'] as List,
          otherdetails: json['otherdetails'] == null ? null: json['otherdetails'] as String, 
          unit: json['unit'] == null ? null: json['unit'] as String,
          imageUrls: json['imageUrls'] == null ? null: json['imageUrls'] as List,
          seller: json['seller'] == null ? null: json['seller'] as Map,
          approved: json['approved'] == null ? null: json['approved'] as bool,
        );

  final String? productName;
  final int? regularPrice;
  final int? salesPrice;
  final String? taxStatus;
  // final double? taxValue;
  final String? category;
  final String? mainCategory;
  final String? subCatName;
  final String? description;
  final Timestamp? scheduleDate;
  final String? sku;
  final bool? manageInventory;
  final int? soh;
  final int? reOrderLavel;
  final bool? chargeShipping;
  final int? shippingCharge;
  final String? brand;
  final List? sizeList;
  final String? otherdetails;
  final String? unit;
  final List? imageUrls;
  final Map? seller;
  final bool? approved;
  final String? productId;

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'regularPrice': regularPrice,
      'salesPrice': salesPrice,
      'taxStatus': taxStatus,
      // 'taxValue': taxValue ,
      'category': category,
      'mainCategory': mainCategory,
      'subCatName': subCatName,
      'description': description,
      'scheduleDate': scheduleDate,
      'sku': sku,
      'manageInventory': manageInventory,
      'soh': soh,
      'reOrderLavel': reOrderLavel,
      'chargeShipping': chargeShipping,
      'shippingCharge': shippingCharge,
      'brand': brand,
      'size': sizeList,
      'otherdetails': otherdetails,
      'unit': unit,
      'imageUrls': imageUrls,
      'approved': approved,
    };
  }
}


productQuery({category}){
  return FirebaseFirestore.instance.collection('product').where('approved',isEqualTo: true).where('category', isEqualTo: category)
  .withConverter<Product>(
     fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
     toFirestore: (product, _) => product.toJson(),
   );
}


allProducts(){
  return FirebaseFirestore.instance.collection('product').withConverter<Product>(
     fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
     toFirestore: (product, _) => product.toJson(),
   );
}







