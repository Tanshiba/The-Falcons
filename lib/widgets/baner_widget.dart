import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:my_multivender_ecommerce_app/firebase_service.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  double scrollPosition = 0;
  final FirebaseService _service = FirebaseService();

  final List bannerImages = [];

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  getBanners() {
    _service.homeBanner.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          bannerImages.add(doc['image']);
        });
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: bannerImages.isEmpty
                  ? GFShimmer(
                      showShimmerEffect: true,
                      secondaryColor: Colors.grey.shade400,
                      mainColor: Colors.grey,
                      child: Container(color: Colors.grey))
                  : PageView.builder(
                      itemCount: bannerImages.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: bannerImages[index],
                          fit: BoxFit.fill,
                        );
                      },
                      onPageChanged: (value) {
                        setState(() {
                          scrollPosition = value.toDouble();
                        });
                      },
                    ),
            ),
          ),
        ),
        DotsIndicatorWidget(
          scrollPosition: scrollPosition,
          dotsCount: bannerImages,
        )
      ],
    );
  }
}

class DotsIndicatorWidget extends StatelessWidget {
  const DotsIndicatorWidget(
      {Key? key, required this.scrollPosition, required this.dotsCount})
      : super(key: key);

  final double scrollPosition;
  final List dotsCount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10.0,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: dotsCount.isEmpty
                  ? null
                  : DotsIndicator(
                      position: scrollPosition,
                      dotsCount: dotsCount.length.toInt(),
                      decorator: DotsDecorator(
                        spacing: const EdgeInsets.all(2),
                        size: const Size.square(6),
                        activeSize: const Size(12, 6),
                        activeColor: Colors.blue,
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';

// class BannerWidget extends StatefulWidget {
//   const BannerWidget({Key? key}) : super(key: key);

//   @override
//   State<BannerWidget> createState() => _BannerWidgetState();
// }

// double scrollPosition = 0;
// // final List _bannerImage = [];

// class _BannerWidgetState extends State<BannerWidget> {
//   // final FirebaseService _service = FirebaseService();

//   // @override
//   // void initState() {
//   //   getBanners();
//   //   super.initState();
//   // }

//   // getBanners() {
//   //   _service.homeBanner.get().then((QuerySnapshot querySnapshot) {
//   //     querySnapshot.docs.forEach((doc) {
//   //       setState(() {
//   //         _bannerImage.add(doc['image']);
//   //       });
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: Container(
//                 height: 140,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.white,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('homeBanner')
//                       .snapshots(),
//                   builder: ((context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     final imageData = snapshot.data!.docs;
//                     return PageView.builder(
//                       itemCount: imageData.length,
//                       itemBuilder: ((context, index) {
//                         return Image.network(imageData[index]['image']);
//                       }),
//                       onPageChanged: (value) {
//                         setState(() {
//                           scrollPosition = value.toDouble();
//                         });
//                       },
//                     );
//                   }),
//                 )),
//           ),
//         ),
//         DotsIndicatorWidget(scrollPosition: scrollPosition)
//       ],
//     );
//   }
// }

// class DotsIndicatorWidget extends StatelessWidget {
//   const DotsIndicatorWidget({
//     Key? key,
//     required this.scrollPosition,
//   }) : super(key: key);

//   final double scrollPosition;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         bottom: 10.0,
//         child: Row(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: DotsIndicator(
//                 position: scrollPosition,
//                 dotsCount: 3,
//                 decorator: DotsDecorator(
//                   spacing: const EdgeInsets.all(2),
//                   size: const Size.square(6),
//                   activeSize: const Size(12, 6),
//                   activeColor: Colors.blue,
//                   activeShape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }
