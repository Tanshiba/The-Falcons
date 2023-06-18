import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/models/category_model.dart';
import 'package:my_multivender_ecommerce_app/models/main_category_model.dart';
import 'package:my_multivender_ecommerce_app/widgets/sub_category_widget..dart';

class MainCategoryWidget extends StatefulWidget {
  final String? selectedCat;
  const MainCategoryWidget({required this.selectedCat, Key? key})
      : super(key: key);

  @override
  State<MainCategoryWidget> createState() => _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends State<MainCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<MainCategory>(
        scrollDirection: Axis.vertical,
        query: mainCategoryCollection(widget.selectedCat),
        itemBuilder: (context, snapshot) {
          // Data is now typed!
          MainCategory mainCategory = snapshot.data();

          // return Card(
          //   child: Column(children: [

          //      SubCategoryWidget(selectedSubCat: mainCategory.mainCategory)
          //   ]),
          // );
          return SingleChildScrollView(
            child: ExpansionTile(
              title: Text(
                mainCategory.mainCategory,
              ),
              children: [
                SubCategoryWidget(selectedSubCat: mainCategory.mainCategory)
              ],
            ),
          );
        },
      ),
    );
  }
}
