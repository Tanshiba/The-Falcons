import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';

import 'package:my_multivender_ecommerce_app/widgets/baner_widget.dart';

class BrandHighlights extends StatefulWidget {
  const BrandHighlights({Key? key}) : super(key: key);

  @override
  State<BrandHighlights> createState() => _BrandHighlightsState();
}

class _BrandHighlightsState extends State<BrandHighlights> {
  double _scrollPosition = 0;

  final FirebaseService _service = FirebaseService();

  final List brandAd = [];

  @override
  void initState() {
    getBrandAd();
    super.initState();
  }

  getBrandAd() {
    _service.brandAd.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          brandAd.add(doc);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Brand highlights',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: brandAd.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    height: 100,
                                    color: Colors.deepOrange,
                                    child: Center(
                                        child: CachedNetworkImage(
                                      imageUrl: brandAd[index]['image3'],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => GFShimmer(
                                          child: Container(
                                        color: Colors.grey,
                                      )),
                                    )),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          height: 50,
                                          color: Colors.red,
                                          child: Center(
                                              child: CachedNetworkImage(
                                            imageUrl: brandAd[index]['image1'],
                                            placeholder: (context, url) =>
                                                GFShimmer(
                                                    child: Container(
                                              height: 50,
                                              color: Colors.grey,
                                            )),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 0, 4, 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          height: 50,
                                          color: Colors.red,
                                          child: Center(
                                              child: CachedNetworkImage(
                                            imageUrl: brandAd[index]['image2'],
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 50,
                                              color: Colors.grey,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                height: 160,
                                color: Colors.blue,
                                child: Center(
                                    child: CachedNetworkImage(
                                  imageUrl: brandAd[index]['image3'],
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => GFShimmer(
                                      child: Container(
                                    height: 160,
                                    color: Colors.grey,
                                  )),
                                )),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  onPageChanged: (value) {
                    setState(() {
                      _scrollPosition = value.toDouble();
                    });
                  },
                ),
                DotsIndicatorWidget(
            scrollPosition: _scrollPosition,
            dotsCount: brandAd,
          ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}








                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(4),
                    //               child: Container(
                    //                 height: 100,
                    //                 color: Colors.deepOrange,
                    //                 child: const Center(
                    //                     child: Text(
                    //                   textAlign: TextAlign.center,
                    //                   'YouTube Ad Video \n About Product',
                    //                   style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 )),
                    //               ),
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsets.fromLTRB(8, 0, 4, 8),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(4),
                    //                     child: Container(
                    //                       height: 50,
                    //                       color: Colors.red,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           textAlign: TextAlign.center,
                    //                           'Ad',
                    //                           style: TextStyle(
                    //                             fontSize: 20,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsets.fromLTRB(4, 0, 4, 8),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(4),
                    //                     child: Container(
                    //                       height: 50,
                    //                       color: Colors.red,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           textAlign: TextAlign.center,
                    //                           'Ad',
                    //                           style: TextStyle(
                    //                             fontSize: 20,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 2,
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(4),
                    //           child: Container(
                    //             height: 160,
                    //             color: Colors.blue,
                    //             child: const Center(
                    //               child: Text(
                    //                 textAlign: TextAlign.center,
                    //                 'Ad',
                    //                 style: TextStyle(
                    //                   fontSize: 20,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(4),
                    //               child: Container(
                    //                 height: 100,
                    //                 color: Colors.deepOrange,
                    //                 child: const Center(
                    //                     child: Text(
                    //                   textAlign: TextAlign.center,
                    //                   'YouTube Ad Video \n About Product',
                    //                   style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 )),
                    //               ),
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsets.fromLTRB(8, 0, 4, 8),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(4),
                    //                     child: Container(
                    //                       height: 50,
                    //                       color: Colors.red,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           textAlign: TextAlign.center,
                    //                           'Ad',
                    //                           style: TextStyle(
                    //                             fontSize: 20,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsets.fromLTRB(4, 0, 4, 8),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(4),
                    //                     child: Container(
                    //                       height: 50,
                    //                       color: Colors.red,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           textAlign: TextAlign.center,
                    //                           'Ad',
                    //                           style: TextStyle(
                    //                             fontSize: 20,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 2,
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(4),
                    //           child: Container(
                    //             height: 160,
                    //             color: Colors.blue,
                    //             child: const Center(
                    //               child: Text(
                    //                 textAlign: TextAlign.center,
                    //                 'Ad',
                    //                 style: TextStyle(
                    //                   fontSize: 20,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(4),
                    //               child: Container(
                    //                 height: 100,
                    //                 color: Colors.deepOrange,
                    //                 child: const Center(
                    //                     child: Text(
                    //                   textAlign: TextAlign.center,
                    //                   'YouTube Ad Video \n About Product',
                    //                   style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 )),
                    //               ),
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsets.fromLTRB(8, 0, 4, 8),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(4),
                    //                     child: Container(
                    //                       height: 50,
                    //                       color: Colors.red,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           textAlign: TextAlign.center,
                    //                           'Ad',
                    //                           style: TextStyle(
                    //                             fontSize: 20,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsets.fromLTRB(4, 0, 4, 8),
                    //                   child: ClipRRect(
                    //                     borderRadius: BorderRadius.circular(4),
                    //                     child: Container(
                    //                       height: 50,
                    //                       color: Colors.red,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           textAlign: TextAlign.center,
                    //                           'Ad',
                    //                           style: TextStyle(
                    //                             fontSize: 20,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 2,
                    //       child: Padding(
                    //         padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(4),
                    //           child: Container(
                    //             height: 160,
                    //             color: Colors.blue,
                    //             child: const Center(
                    //               child: Text(
                    //                 textAlign: TextAlign.center,
                    //                 'Ad',
                    //                 style: TextStyle(
                    //                   fontSize: 20,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // )