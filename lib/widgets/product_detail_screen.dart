


import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';
import 'package:my_multivender_ecommerce_app/models/product_model.dart';
import 'package:my_multivender_ecommerce_app/screens/confirmation_screen.dart';
import 'package:my_multivender_ecommerce_app/screens/google_map_screen.dart';
import 'package:my_multivender_ecommerce_app/widgets/product_bottom_sheet.dart';
class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final Product product;
  const ProductDetailScreen({super.key, required this.product, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final FirebaseService _service = FirebaseService();
  final store = GetStorage();
  int? pageNumber =0;
  ScrollController? _scrollController;
  bool _isScrollDown = false;
  bool _showAppBar = true;
  String? _selectedSize;   
  String? _address;

   User? user = FirebaseAuth.instance.currentUser;
 

  @override
  void initState() {
     getDeliveryAddress();
     getSize();
    _scrollController = ScrollController();
   _scrollController!.addListener(() {
    if(_scrollController!.position.userScrollDirection == ScrollDirection.reverse){
     if(!_isScrollDown){
      setState(() {
        _isScrollDown =true ;
        _showAppBar = false;
       
      });
     }
    }
     if(_scrollController!.position.userScrollDirection == ScrollDirection.forward){
     if(_isScrollDown){
      setState(() {
        _isScrollDown = false;
         _showAppBar = true;
       
      });
     }
    }
    });
    super.initState();
  }

  getSize(){
    if(widget.product.sizeList!= null ){
      setState(() {
        _selectedSize = widget.product.sizeList![0];
      });
    }
  }

  getDeliveryAddress(){
   String? address = store.read('address');
   if(address!=null){
    setState(() {
      _address =address;
    });
   }
  }

   Widget _sizedBox({double? height, double? width,}){
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
   }
   Widget _devider(){
    return Divider(
      color: Colors.grey.shade400,
      thickness: 1,

    );
   }

   Widget _headText(String? text){
    return     Text(text!, style: TextStyle(fontSize: 12, color: Colors.grey),);
   }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _showAppBar ? AppBar(
        elevation: 0,
        
        iconTheme: const IconThemeData(color: Colors.grey),
        actions:  [
          const CircleAvatar(
            backgroundColor: Colors.black26,
            radius: 18,
            child: Icon(IconlyLight.buy,color: Colors.white,)),
           _sizedBox(width: 10),
              const CircleAvatar(
            backgroundColor: Colors.black26,
            radius: 18,
            child: Icon(Icons.more_horiz,color: Colors.white,)),
            _sizedBox(width: 10),
          
        ],
        title: Text(widget.product.productName!),
      ):null, 
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            height: 300,
            child: Stack(
              children: [Hero(
                
                tag: widget.product.imageUrls![0],
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      pageNumber = value;
                    });
                  },
                 children: widget.product.imageUrls!.map((e){
                  return CachedNetworkImage(imageUrl: e, fit: BoxFit.contain,);
                 }).toList(),
                ),
              ),
              Positioned(
                bottom: 10,
                right: MediaQuery.of(context).size.width/2.2,
                child: CircleAvatar(
      
                  minRadius: 14,
                  child:  Text('${pageNumber!+1}/${widget.product.imageUrls!.length}',style: const TextStyle(color: Colors.red),)))
      
              ]
            ),
            
          )
         , Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children:[ Text('Rs.  ${widget.product.salesPrice!=null ? _service.formatedNumber(widget.product.salesPrice) : _service.formatedNumber(widget.product.regularPrice)}' ,
                 style: TextStyle(fontWeight: FontWeight.bold,
                 color: Theme.of(context).primaryColor, fontSize: 18,),),
                 Row(
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: (){}, icon: const Icon(IconlyLight.heart,size: 16,color: Colors.grey,),),
                  
                    IconButton(
                      splashRadius: 20,
                     
                      onPressed: (){}, icon: const Icon(Icons.share, size: 16, color: Colors.grey,),),
                  ],
                 )
             ],),
               if(widget.product.salesPrice!=null)
               Row(
                children: [
                  Text('Rs.  ${_service.formatedNumber(widget.product.regularPrice)}', 
                  style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
                const SizedBox(width: 10,),
                Text('${(((widget.product.regularPrice!-widget.product.salesPrice!)/widget.product.regularPrice!)*100).toStringAsFixed(0)}%')
                ],
               )
                , _sizedBox(height   : 10),
                Text(widget.product.productName!, style: const TextStyle(),),
      
                Row(
                  children: [
                    Icon(IconlyBold.star, color: Theme.of(context).primaryColor, size: 14,),
                    Icon(IconlyBold.star, color: Theme.of(context).primaryColor, size: 14,),
                    Icon(IconlyBold.star, color: Theme.of(context).primaryColor, size: 14,),
                    Icon(IconlyBold.star, color: Theme.of(context).primaryColor, size: 14,),
                    Icon(IconlyBold.star, color: Theme.of(context).primaryColor, size: 14,),
      
                    _sizedBox(width: 4),
                    const Text('(5)', style: TextStyle(fontSize: 12, ),)
                  ],
                ),
                _sizedBox(height: 10),
                 Text(widget.product.description!),
                 if(widget.product.sizeList!= null && widget.product.sizeList!.isNotEmpty)
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      _sizedBox(height: 10),
                 _headText('Varitations'),
                 
                 SizedBox(
                  height: 50,
                   child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: 
                      widget.product.sizeList!.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                _selectedSize == e  ? Theme.of(context).primaryColor :Colors.white,
                              ),
                            ),
                            child: Text(e, style: TextStyle(color: _selectedSize == e  ? Colors.white : Theme.of(context).primaryColor),),
                            onPressed: (){
                              setState(() {  
                                _selectedSize = e;
                              });
                            },
                          ),
                        );
                      }).toList()
                    ,
                   ),
                 ),
                
                  ],
                 ),
                 _devider(),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context, builder: (context){
                      return ProductBottomSheet(product: widget.product ,);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6,bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                       _headText('Specifications'),
                        Icon(IconlyLight.arrowRight2,size: 14 ,)
                      ],
                    ),
                  ),
                ),
      
                _devider(),
                Row(
                  children: [
                   Expanded(
                    flex: 2,
                    child: _headText('Delivery')),
                     Expanded(
                      flex: 3,
                      child: Column(
                      children:  [
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => MapScreen(detailScreen: true   ),)
                              
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              Flexible(
                                child: Text(_address ?? 'Delivery address not set..', 
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14, color: Colors.red
                                ),
                                ),
                              ),
                              Icon(IconlyLight.location) ],
                          ),
                        ),
                         _sizedBox(height: 6),
                        Text('Home Delivery 3-5 day(s)', style: TextStyle(fontSize: 14,),),
                        Text('Delivery Charge : ${widget.product.chargeShipping! ? 'Rs.${widget.product.shippingCharge}': 'Free'}')
                        
                      ],
                     )),
                  ],
                ),
              _devider(),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                  _headText('Rating & Reviews (10)'),
                   _headText('View all..')
                  ],
                ),
                _sizedBox(height: 10),
                Row(
                  children: [
                    Text('Sm It - 11 Feb 2022', style: TextStyle(color: Colors.grey, fontSize: 12,),),
                    Row(
                      children: [
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyLight.star,size: 12, color: Theme.of(context).primaryColor,),
      
                      ],
                    ),
                    
                     _sizedBox(height: 10),
      
                  ],
                ),
                Text('Good Product, good quality\non time delivery'),
      
                   _sizedBox(height: 10),
                Row(
                  children: [
                    Text('Sm It - 11 Feb 2022', style: TextStyle(color: Colors.grey, fontSize: 12,),),
                    Row(
                      children: [
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyLight.star,size: 12, color: Theme.of(context).primaryColor,),
      
                      ],
                    ),
                    
                   _sizedBox(height: 10),
       
                  ],
                ),
                Text('Good Product, good quality\non time delivery'),
      
                       _sizedBox(height: 10),
                Row(
                  children: [
                    Text('Sm It - 11 Feb 2022', style: TextStyle(color: Colors.grey, fontSize: 12,),),
                    Row(
                      children: [
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyLight.star,size: 12, color: Theme.of(context).primaryColor,),
      
                      ],
                    ),
                    
                    _sizedBox(height: 10),
      
                  ],
                ),
                Text('Good Product, good quality\non time delivery'),
                                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Sm It - 11 Feb 2022', style: TextStyle(color: Colors.grey, fontSize: 12,),),
                    Row(
                      children: [
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyLight.star,size: 12, color: Theme.of(context).primaryColor,),
      
                      ],
                    ),
                    
                    _sizedBox(height: 10),
      
                  ],
                ),
                Text('Good Product, good quality\non time delivery'),
      
                 _sizedBox(height: 10),
                Row(
                  children: [
                    Text('Sm It - 11 Feb 2022', style: TextStyle(color: Colors.grey, fontSize: 12,),),
                    Row(
                      children: [
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyLight.star,size: 12, color: Theme.of(context).primaryColor,),
      
                      ],
                    ),
                    
                  _sizedBox(height: 10),
      
                  ],
                ),
                Text('Good Product, good quality\non time delivery'),
      
                      _sizedBox(height: 10),
                Row(
                  children: [
                    Text('Sm It - 11 Feb 2022', style: TextStyle(color: Colors.grey, fontSize: 12,),),
                    Row(
                      children: [
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyBold.star,size: 12, color: Theme.of(context).primaryColor,),
                        Icon(IconlyLight.star,size: 12, color: Theme.of(context).primaryColor,),
      
                      ],
                    ),
                    
                    _sizedBox(height: 10),
      
                  ],
                ),
                Text('Good Product, good quality\non time delivery'),
             ],
           ),
         ),
         Container(height: 200,)
        ]),
        
        ),

      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade400))
        ),
        height: 60,
        child: Row(
          children: [
           _sizedBox(width: 10),
            Column(
              children: [
                SizedBox(width: 20,),
                Icon(Icons.store_mall_directory_outlined,color: Theme.of(context).primaryColor,),
                Text('Store', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12,),
               ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: VerticalDivider(color: Colors.grey,),
            ),

               _sizedBox(width: 20),
            Column(
              children: [
                _sizedBox(width: 10),
                Icon(Icons.store_mall_directory_outlined,color: Theme.of(context).primaryColor,),
                Text('Store', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12,),
               ),
              ],
            ),
          FittedBox(
             child: Row(
              children: [ 
                 ElevatedButton(onPressed: ()async{
                  // // store.remove('address');
                  // _address == null ? 
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen())).whenComplete(() {
                    
                  // }): 
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmationScreen()));
                     EasyLoading.show(status: 'Please wait...');
                await  _service.addOrders(data: {
                    'productName' : widget.product.productName,
                    'productImage': widget.product.imageUrls![0],
                    'productPrice': widget.product.salesPrice,
                    'userId': user!.uid
                  });

                EasyLoading.dismiss();
                 }, child: const Text('Buy Now')),
              SizedBox(width: 10,),
              ElevatedButton(onPressed: ()async{
                 EasyLoading.show(status: 'Please wait...');
                await  _service.addVendor(data: {
                    'productName' : widget.product.productName,
                    'productImage': widget.product.imageUrls![0],
                    'productPrice': widget.product.salesPrice,
                    'userId': user!.uid
                  });

                EasyLoading.dismiss();
              },
               child: const Text('Add to Cart'),),
              ],
             ),
           )
  
          ],
        ),
      ) ,
    );
  } 
} 