

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';


class CartItem {
  CartItem({
    this.productName,
    this.userId,
    this.salesPrice,
    this.imageUrls,

  });

  CartItem.fromJson(Map<String, Object?>json)
      : this(
          productName: json['productName'] as String,
          salesPrice: json['productPrice'] == null ? null: json['productPrice'] as int,
          imageUrls: json['productImage'] == null ? null: json['productImage'] as String,
          userId: json['userId'] as String,

        );

  final String? productName;
  final int? salesPrice;
  final String? userId;
  final String? imageUrls;
  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'productPrice': salesPrice,
      'productImage': imageUrls,
      'userId': userId,
      
    };
  }
}

FirebaseService services = FirebaseService();

productQuery() {
  return FirebaseFirestore.instance
      .collection('cartItems')
      .where('userId', isEqualTo:services.user!.uid).withConverter<CartItem>(
        fromFirestore: (snapshot, _) => CartItem.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}


orderItemQuery() {
  return FirebaseFirestore.instance
      .collection('orderItems')
      .where('userId', isEqualTo:services.user!.uid).withConverter<CartItem>(
        fromFirestore: (snapshot, _) => CartItem.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:my_multivender_ecommerce_app/firebase_service.dart';

// // class CartItem {
// //     final String cartId;
// //   final String cartName;
// //   final String cartImage;
// //   final double cartPrice;
// //   final String quality;
// //   CartItem({
// //     required this.cartId,
// //     required this.cartName,
// //     required this.cartImage,
// //     required this.cartPrice,
// //     required this.quality,
// //   });
// // }

// class Cart extends ChangeNotifier{

//  void addReviewCartData({
//     required String cartId,
//     required String cartName,
//     required String cartImage,
//     required int cartPrice,
//     required String cartQuantity

//   })async{
//     await FirebaseFirestore.instance.collection('ReviewCart')
//     .doc(FirebaseAuth.instance.currentUser!.uid).collection('yourReviewCart').doc(cartId).set(
//       {
//         'cartId': cartId,
//         'cartName': cartName,
//         'cartImage': cartImage,
//         'cartPrice': cartPrice,
//         'cartQuantity': cartQuantity,
//       }
//     );
//   }
//   // FirebaseService _services = FirebaseService();
//   //   Map<String, CartItem> _items = {};
//   //   Map<String,CartItem> get items{
//   //   return {..._items};
//   //   }
 
//   // QuerySnapshot? snapshot;
//   //    getCartList() {
//   //   _services.categories.get().then((QuerySnapshot querySnapshot) {
    
//   //       snapshot = querySnapshot
        
//   //       notifyListeners();
//   //   });
//   // }

    
// }






// // import 'package:flutter/cupertino.dart';

// // class CartItem{
// //   final String id;
// //   final String title;
// //   final int quantity;
// //   final double price;

// //   CartItem({required this.id, required this.title, required this.quantity, required this.price});
  
// // }
// // class Cart with ChangeNotifier{
// //    Map<String, CartItem> _items = {};
// //   Map<String,CartItem> get items{
// //     return {..._items};
// //   }

// //   int get itemCount{
// //     return  _items.length;
// //   }
// //   double get totleAmount{
// //     var totle = 0.0;
// //     _items.forEach((key, cartItem) {
// //       totle += cartItem.price * cartItem.quantity;
// //      });
// //     return totle;
// //   }

// //   void addItem(String productId, double price, String title){
// //     if( _items.containsKey(productId)){
// //       _items.update(productId, (existingCartItem) => CartItem(
// //         id: existingCartItem.id, 
// //         title: existingCartItem.title, 
// //         quantity: existingCartItem.quantity +1, 
// //         price: existingCartItem.price
// //         )
// //       );
// //       //change quantity
// //     }else{
// //       _items.putIfAbsent(
// //         productId, () => CartItem(
// //           id: DateTime.now().toString(), 
// //           title: title, 
// //           quantity: 1, 
// //           price: price
// //           )
// //         );
// //     }
// //     notifyListeners();
// //   }
// //   void removeItem(String productId){
// //     _items.remove(productId);
// //     notifyListeners();
// //   }

// //    removeSingleItem(String productId){
// //     if(!_items.containsKey(productId)){
// //       return;
// //     }
// //     if(_items[productId]!.quantity>1){
// //       _items.update(productId, (existingCartItem) => CartItem(
// //         id: existingCartItem.id, 
// //         title: existingCartItem.title, 
// //         quantity: existingCartItem.quantity -1, 
// //         price: existingCartItem.price,
// //         )
// //         );
// //     }else{
// //       _items.remove(productId);
// //     }
// //     notifyListeners();
// //   }
// //   void clearCart (){
// //     _items ={};
// //     notifyListeners();
// //   }
// // }