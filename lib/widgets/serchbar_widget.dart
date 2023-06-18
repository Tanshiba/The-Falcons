import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';
import 'package:my_multivender_ecommerce_app/models/product_model.dart';
import 'package:my_multivender_ecommerce_app/providers/cart_provider.dart';
import 'package:my_multivender_ecommerce_app/widgets/product_detail_screen.dart';
import 'package:search_page/search_page.dart';

class SerchBarWidget extends StatefulWidget {
  const SerchBarWidget({
    Key? key,  
    this.snapshot,   
  }) : super(key: key);
  final FirestoreQueryBuilderSnapshot? snapshot;
  @override
  State<SerchBarWidget> createState() => SerchBarWidgetState();
}
class SerchBarWidgetState extends State<SerchBarWidget> {
 
  @override
  void initState() {
   getProductList();
    super.initState();
  }
   final List<Product> _productList = [];
  getProductList(){
    return  widget.snapshot!.docs.forEach((element) {
      Product product = element.data();
  setState(() {
    _productList.add(Product(
      approved: product.approved,
      brand: product.brand,
      category: product.category,
      chargeShipping: product.chargeShipping,
      description: product.description,
      imageUrls: product.imageUrls,
      mainCategory: product.mainCategory,
      manageInventory: product.manageInventory,
      otherdetails: product.otherdetails,
      productName: product.productName,
      reOrderLavel: product.reOrderLavel,
      regularPrice: product.regularPrice,
      salesPrice: product.salesPrice,
      scheduleDate: product.scheduleDate,
      seller: product.seller,
      shippingCharge: product.shippingCharge,
      sizeList: product.sizeList,
      sku: product.sku,
      soh: product.soh,
      subCatName: product.subCatName,
      taxStatus: product.taxStatus,
      unit: product.unit,
      productId: element.id
    ));
  });
 });
}
  Widget _productsCard(){
   return ListView.builder(
                        itemCount: widget.snapshot!.docs.length,
                        itemBuilder: (context, index) {
                        Product product = widget.snapshot!.docs[index].data();
                        String id = widget.snapshot!.docs[index].id;
                        var discount = (product.regularPrice!-product.salesPrice!)/product.regularPrice!*100;
                        return  Slidable(
                          endActionPane: ActionPane(
                                motion: ScrollMotion(), children: [
                                  SlidableAction(
                                    flex: 1,
                
                                    onPressed:(context) {
                                      // services.product.doc(id).delete();
                                    } ,
                
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                     
                                     ),
                
                                            SlidableAction(
                                    flex: 1,
                
                                    onPressed:(context) {
                                      // services.product.doc(id).update({
                                      //   'approved': product.approved == false ? true:false,
                                      // });
                                    } ,
                
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    icon: Icons.save,
                                    label: product.approved ==false ? 'Approve' : 'Inactive',
                                     )
                                ],
                              ),child: 
                        InkWell(
                          onTap: (() {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context ) =>  ProductDetailScreen(product: product,productId: id,)));
                          }),
                          child: Card( 
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 80 ,
                                  width: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(imageUrl: product.imageUrls![0]),
                                  ),),
                                  const SizedBox(width: 10,),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                       Text(product.productName!),
                                       if(product.salesPrice!=null)
                                      Row(children: [
                                             Text(services.formatedNumber(product.salesPrice)), 
                                             const SizedBox(width: 10,), 
                                    Text(services.formatedNumber(product.regularPrice), 
                                    style:TextStyle( decoration: product.salesPrice!=null ? TextDecoration.lineThrough : null, color: Colors.red,),),
                                     const SizedBox(width: 10,),
                                     Text('${discount.toInt()}% off', style: const TextStyle(color: Colors.red),)
                                      ],),
                                    ],
                                   ),
                                 )
                              ],
                            ),
                        ),
                       ), 
                     );
                    },
                  );
               }
  @override
  Widget build(BuildContext context) {
   FirebaseService services = FirebaseService();
   
    return  TextField(
      onTap:(() {
        showSearch(
    context: context,
    delegate: SearchPage<Product>(
    // onQueryUpdate: print,
    items: _productList,
    searchLabel: 'Search products',
    suggestion: _productsCard(),
    failure: const Center(
    child: Text('No product found :('),
    ),
    filter: (product) => [
    product.productName,
    product.category,
    product.mainCategory,
    product.subCatName,
    ], 
    // sort: (a, b) => a.compareTo(b),
    builder: (product) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80 ,
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0), 
            child: CachedNetworkImage(imageUrl: product.imageUrls![0]),
          ),),
          const SizedBox(width: 10,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
               Text(product.productName!),
               if(product.salesPrice!=null)
              Row(children: [
                     Text(services.formatedNumber(product.salesPrice)), 
                     const SizedBox(width: 10,), 
            Text(services.formatedNumber(product.regularPrice), 
            style:TextStyle( decoration: product.salesPrice!=null ? TextDecoration.lineThrough : null, color: Colors.red,),),
             
          
              ],),
            ],
           ),
         )
      ],
    ),
    ),
    ),  
    );
    
      }),
      decoration: InputDecoration( 
        hintText: 'Serch Products',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.only(bottom: 10, right: 10,left: 10),
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
    
      ),
    );
    
  }
}
