import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';
import 'package:my_multivender_ecommerce_app/models/product_model.dart';
import 'package:my_multivender_ecommerce_app/widgets/product_detail_screen.dart';

class AllProductList extends StatefulWidget {

  
  const AllProductList({
    Key? key,
    
  }) : super(key: key);

  @override
  State<AllProductList> createState() => _AllProductListState();
}

class _AllProductListState extends State<AllProductList> {
  @override
  Widget build(BuildContext context) {
    
       FirebaseService _service = FirebaseService();
    return FirestoreQueryBuilder<Product>(
  query: allProducts(),
  builder: (context, snapshot, _) {
    // ...
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.docs.length,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1/1.3) ,
      itemBuilder: (context, index) {
     
        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
  
          snapshot.fetchMore(); 
        }

        var productIndex = snapshot.docs[index];

        Product product = productIndex.data();
        String productId = productIndex.id;
        var productQuty = product.unit;
      
        return InkWell(
          onTap: (() {
          Navigator.push(
            context,

            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, __, ___) {
              return
              ProductDetailScreen(product: product, productId: productId);
            })
          );
          }),
          child: Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child:  Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Hero(tag: product.imageUrls![0],
                    child: CachedNetworkImage(imageUrl: product.imageUrls![0])),
                  ),
                ),
                Text(product.productName!, style: TextStyle(color: Colors.red),),
              ],
            ),
          ),
        );
      }, 
    );
  },
);
    
}
}
