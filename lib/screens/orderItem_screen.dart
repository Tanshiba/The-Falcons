import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/models/product_model.dart';
import 'package:my_multivender_ecommerce_app/providers/cart_provider.dart';

class OrederItemScreen extends StatelessWidget {
  const OrederItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: FirestoreQueryBuilder<CartItem>(
        query: orderItemQuery(),
        builder: (context, snapshot, child) {
            if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }


          if(snapshot.docs.isEmpty){
            return Center(child: Text('No Orders'));
          }

          return ListView.builder(
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              var productIndex = snapshot.docs[index];
              CartItem orderItem = productIndex.data();  
              String orderId = productIndex.id;

              return Card(
                color: Colors.grey,
                child: ListTile(
                  leading: orderItem.imageUrls == null ? Text('') :
                   CircleAvatar(
                  backgroundImage:  NetworkImage(orderItem.imageUrls.toString()),
                  ),
                  title: Text(orderItem.productName.toString()),
                  trailing: Text(orderItem.salesPrice.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}