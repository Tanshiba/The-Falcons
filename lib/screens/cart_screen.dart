import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'package:my_multivender_ecommerce_app/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  deleteProd(idd)async{
    await FirebaseFirestore.instance.collection('cartItems').doc(idd).delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FirestoreQueryBuilder<CartItem>(
        query: productQuery(),
        builder: (context, snapshot, child) {
              if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }


          if(snapshot.docs.isEmpty){
            return Center(child: Text('No UnPublished Products'));
          }

          return ListView.builder(
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
               CartItem product =  snapshot.docs[index].data();
               String id = snapshot.docs[index].id;
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Card(
                color: Colors.grey,
                 child: ListTile(
                  onLongPress: () {
                    deleteProd(id);
                  },
                  leading:  product.imageUrls == null ? Text('') :
                   Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: CircleAvatar(
                      backgroundImage:  NetworkImage(product.imageUrls.toString(), ),
                    ),
                  ),
                  title: Text( product.productName.toString()) ,
                 ),
               ),
             ); 
            },
          );
        },
      )
    );
  }
}
