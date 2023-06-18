// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:my_multivender_ecommerce_app/models/category_model.dart';
// import 'package:flutterfire_ui/firestore.dart';

// class CategoryWidget extends StatefulWidget {
//   const CategoryWidget({Key? key}) : super(key: key);

//   @override
//   State<CategoryWidget> createState() => _CategoryWidgetState();
// }

// class _CategoryWidgetState extends State<CategoryWidget> {
//   final List<String> _categoryLable = [
//     '*Picked For You',
//     'Mobiles',
//     'Fashion',
//     'Groceries'
//   ];

//   int _index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 18,
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Stores For You',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(4),
//             child: SizedBox(
//               height: 40,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _categoryLable.length,
//                       itemBuilder: ((context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(right: 8),
//                           child: ActionChip(
//                               padding: EdgeInsets.zero,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(2)),
//                               backgroundColor:
//                                   _index == index ? Colors.blue : Colors.grey,
//                               label: Text(
//                                 _categoryLable[index],
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: _index == index
//                                       ? Colors.white
//                                       : Colors.white,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _index = index;
//                                 });
//                               }),
//                         );
//                       }),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(IconlyLight.arrowDown),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:my_multivender_ecommerce_app/models/category_model.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/screens/main_screen.dart';
import 'package:my_multivender_ecommerce_app/widgets/home_all_product_list.dart';
import 'package:my_multivender_ecommerce_app/widgets/home_product_list.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // final List<String> _categoryLable = [
  //   '*Picked For You',
  //   'Mobiles',
  //   'Fashion',
  //   'Groceries'
  // ];

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:   [
                  Text(
                    'Stores For You',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(onPressed: (){}, child: const Text('View All',style: TextStyle(fontSize: 12),),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                        child: FirestoreListView<Category>(
                      scrollDirection: Axis.horizontal,
                      query: categoryCollection,
                      itemBuilder: (context, snapshot) {
                        // Data is now typed!
                        Category category = snapshot.data();
      
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ActionChip(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              backgroundColor:
                                  _selectedCategory == category.catName
                                      ? Colors.blue.shade900
                                      : Colors.grey,
                              label: Text(
                                category.catName,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: _selectedCategory == category.catName
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedCategory = category.catName;
                                  print(_selectedCategory);
                                });
                              }),
                        );
                      },
                    )
      
                        //  ListView.builder(
                        //   scrollDirection: Axis.horizontal,
                        //   itemCount: _categoryLable.length,
                        //   itemBuilder: ((context, index) {
                        //     return Padding(
                        //       padding: const EdgeInsets.only(right: 8),
                        //       child: ActionChip(
                        //           padding: EdgeInsets.zero,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(2)),
                        //           backgroundColor:
                        //               _index == index ? Colors.blue : Colors.grey,
                        //           label: Text(
                        //             _categoryLable[index],
                        //             style: TextStyle(
                        //               fontSize: 12,
                        //               color: _index == index
                        //                   ? Colors.white
                        //                   : Colors.white,
                        //             ),
                        //           ),
                        //           onPressed: () {
                        //             setState(() {
                        //               _index = index;
                        //             });
                        //           }),
                        //     );
                        //   }),
                        // ),
                        ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(color: Colors.grey.shade400))),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MainScreen(
                                        index: 1,
                                      )));  
                        },
                        icon: const Icon(IconlyLight.arrowDown),
                      ),
                    ),
                  ],
                ),
              ),
            ),
               _selectedCategory ==null?
               Container(
                
                child: AllProductList()
               ):
            Container(
              height: 500,
             
            child: HomeProductsList(caategory: _selectedCategory!)
            )
            
          ],
        ),
      ),
    );
  }
}
