import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/models/category_model.dart';
import 'package:my_multivender_ecommerce_app/models/main_category_model.dart';
import 'package:my_multivender_ecommerce_app/models/sub_category_model.dart';

class SubCategoryWidget extends StatelessWidget {
  final String? selectedSubCat;
  const SubCategoryWidget({required this.selectedSubCat, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<SubCategory>(
      query: subCategoryCollection(selectedSubCat: selectedSubCat),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        // ...

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1 / 1.1),
          itemCount: snapshot.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            SubCategory subCat = snapshot.docs[index].data();
            return SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: CachedNetworkImage(
                    imageUrl: subCat.image,
                    placeholder: ((context, url) {
                      return Container(
                        height: 60,
                        width: 60,
                        color: Colors.grey.shade300,
                      );
                    }),
                  )),
            );
          },
        );
      },
    );
  }
}
