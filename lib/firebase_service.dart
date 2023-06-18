import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  CollectionReference homeBanner =
      FirebaseFirestore.instance.collection('homeBanner');
  CollectionReference brandAd =
      FirebaseFirestore.instance.collection('brandAd');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories =
      FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =
      FirebaseFirestore.instance.collection('subCategories');
  CollectionReference cartItems =
      FirebaseFirestore.instance.collection('cartItems');

   CollectionReference orderItems =
      FirebaseFirestore.instance.collection('orderItems');

        User? user = FirebaseAuth.instance.currentUser;

      String formatedNumber(number){
        var f = NumberFormat('#,##,###');
        String formatedNumber= f.format(number);
        return formatedNumber;
      }
    Future<void> addVendor({required Map<String, dynamic>? data}) {
    var error;
    return cartItems
        .add(data)
        .then((value) => print('User Added'))
        .catchError((onError) => print('Faild To Add:$error'));
  }
    Future<void> addOrders({required Map<String, dynamic>? data}) {
    var error;
    return orderItems
        .add(data)
        .then((value) => print('User Added'))
        .catchError((onError) => print('Faild To Add:$error'));
  }
}
