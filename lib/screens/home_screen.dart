import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';
import 'package:my_multivender_ecommerce_app/models/category_model.dart';
import 'package:my_multivender_ecommerce_app/models/product_model.dart';
import 'package:my_multivender_ecommerce_app/providers/cart_provider.dart';
import 'package:my_multivender_ecommerce_app/widgets/badge.dart';
import 'package:my_multivender_ecommerce_app/widgets/baner_widget.dart';
import 'package:my_multivender_ecommerce_app/widgets/brand_highlights.dart';
import 'package:my_multivender_ecommerce_app/widgets/category_widget.dart';
import 'package:my_multivender_ecommerce_app/widgets/serchbar_widget.dart';
import 'package:search_page/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseService _services = FirebaseService();

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'MediEquip',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
            ),
          ),
          actions: [
            StreamBuilder<QuerySnapshot>(
                stream: _services.categories.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('error${snapshot.error}');
                  }
                  return Badges(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(IconlyLight.buy),
                      ),
                      value:
                          snapshot.data!.size == null ? 0 : snapshot.data!.size,
                      color: Colors.orange);
                  //
                })
            // Consumer<Cart>(
            //   builder: (context, cart, child) => BBadge(
            //     child: child,
            //     value: ,
            //     color: Colors.orange),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(IconlyLight.buy),
            //   ),
            // ),
          ],
        ),
      ),
      body: ListView(
        children: [
          FirestoreQueryBuilder<Product>(
            query: allProducts(),
            builder: (context, snapshot, child) {
              if (snapshot.isFetching) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              }

              if (snapshot.docs.isEmpty) {
                return Center(child: Text('No UnPublished Products'));
              }
              return SizedBox(
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SerchBarWidget(
                        snapshot: snapshot,
                      )),
                ),
              );
            },
          ),
          // SerchBarWidget(),
          SizedBox(),
          BannerWidget(),
          BrandHighlights(),
          CategoryWidget()
        ],
      ),
    );
  }
}
//   //categoryCollection
// class SearchWidget extends StatelessWidget {
//   const SearchWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FirestoreQueryBuilder(
//           query: allProducts(),
//           builder: (context, snapshot, child) {
//             return SizedBox(
//             height: 55,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(4),
//                 child:  SerchBarWidget(snapshot: snapshot,)
//               ),
//             ),
//           );
//           },

//         ),
//         SizedBox(
//             height: 20,
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: const [
//                     Icon(
//                       IconlyLight.infoSquare,
//                       size: 12,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       '100% genun',
//                       style: TextStyle(color: Colors.white, fontSize: 10),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: const [
//                     Icon(
//                       IconlyLight.infoSquare,
//                       size: 12,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       '7-14 replacement',
//                       style: TextStyle(color: Colors.white, fontSize: 10),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: const [
//                     Icon(
//                       IconlyLight.infoSquare,
//                       size: 12,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       'Thousand brand',
//                       style: TextStyle(color: Colors.white, fontSize: 10),
//                     )
//                   ],
//                 ),
//               ],
//             ))
//       ],
//     );
//   }
// }

// // import 'package:cloud_firestore/cloud_firestore.dart';

// // import 'package:flutter/material.dart';

// // import 'package:flutter_application_1000/firebase_services.dart';

// // class MainCategoriesListWidget extends StatefulWidget {
// //   const MainCategoriesListWidget({Key? key}) : super(key: key);

// //   @override
// //   State<MainCategoriesListWidget> createState() =>
// //       _MainCategoriesListWidgetState();
// // }

// // class _MainCategoriesListWidgetState extends State<MainCategoriesListWidget> {
// //   final FirebaseServices _services = FirebaseServices();

// //   Object? _selectedValue;
// //   bool _noCategorySelected = false;
// //   QuerySnapshot? snapshot;

// //   Widget categoryWidget(data) {
// //     return Card(
// //       color: Colors.grey,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             data['mainCategory'],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _dropDownButton() {
// //     return DropdownButton(
// //         value: _selectedValue,
// //         hint: const Text('Select Category'),
// //         items: snapshot!.docs.map((e) {
// //           return DropdownMenuItem<String>(
// //             value: e['catName'],
// //             child: Text(e['catName']),
// //           );
// //         }).toList(),
// //         onChanged: (selectedCat) {
// //           setState(() {
// //             _selectedValue = selectedCat;
// //             _noCategorySelected = false;
// //           });
// //         });
// //     // return FutureBuilder<QuerySnapshot>(
// //     //     future: _services.categories.get(),
// //     //     builder: ((context, snapshot) {
// //     //       if (snapshot.hasError) {
// //     //         return const Text('Somthing went wrong');
// //     //       }
// //     //       if (snapshot.connectionState == ConnectionState.waiting) {
// //     //         return const LinearProgressIndicator();
// //     //       }
// //     //       return
// //     //     }
// //     //     ),
// //     //     );
// //   }

// //   @override
// //   void initState() {
// //     getCatList();
// //     super.initState();
// //   }

// //   getCatList() {
// //     _services.categories.get().then((QuerySnapshot querySnapshot) {
// //       setState(() {
// //         snapshot = querySnapshot;
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         snapshot == null
// //             ? Text('Loading')
// //             : Row(children: [
// //                 _dropDownButton(),
// //                 const SizedBox(
// //                   width: 10,
// //                 ),
// //                 ElevatedButton(
// //                     onPressed: () {
// //                       setState(() {
// //                         _selectedValue = null;
// //                       });
// //                     },
// //                     child: const Text('Show All'))
// //               ]),
// //         StreamBuilder<QuerySnapshot>(
// //           stream: _services.mainCat
// //               .where('category', isEqualTo: _selectedValue)
// //               .snapshots(),
// //           builder: (context, snapshot) {
// //             if (snapshot.hasError) {
// //               return const Text('Something went wrong');
// //             }
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return const LinearProgressIndicator();
// //             }
// //             if (snapshot.data!.size == 0) {
// //               return const Center(
// //                 child: Text('No Main Categories Added'),
// //               );
// //             }
// //             return GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: snapshot.data!.docs.length,
// //               itemBuilder: (BuildContext context, int index) {
// //                 var data = snapshot.data!.docs[index];
// //                 return categoryWidget(data);
// //               },
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 6,
// //                 crossAxisSpacing: 3,
// //                 childAspectRatio: 6 / 2,
// //                 mainAxisSpacing: 3,
// //               ),
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }
// // }
