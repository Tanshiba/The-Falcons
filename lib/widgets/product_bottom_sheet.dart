import 'package:flutter/material.dart';

import 'package:my_multivender_ecommerce_app/models/product_model.dart';
class ProductBottomSheet extends StatelessWidget {
  final Product? product;
  const ProductBottomSheet({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _customContainer({String? head, String? details,}){
      return  Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(head!,style: TextStyle(color: Colors.grey),),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 6, bottom: 6,),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 10,),
                        SizedBox(width: 10,),
                        Text(details!),
                      ],
                    ),
                  )
                ],
              ),
            );
    }
    return Container(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text('Specification', style: TextStyle(fontSize: 20,color: Colors.black),),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.close))],
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children:[ 
              if(product!.brand!=null)
              _customContainer(
                head: 'Brand',
                details: product!.brand
              ),
              if(product!.unit!= null)
              _customContainer(
                head: 'unit',
                details: product!.unit
              ),
                 if(product!.otherdetails!=null)
              Text(product!.otherdetails!),
              SizedBox(
                height: 10,
              ),
              if(product!.sku!= null)
              _customContainer(
                head: 'SKU',
                details: product!.sku
              )
             ]),
          ),
        ],
      ),
    );
  }
}
