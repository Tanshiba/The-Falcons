import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:my_multivender_ecommerce_app/models/category_model.dart';
import 'package:my_multivender_ecommerce_app/widgets/main_category_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _title = 'categories';
  String? _selectedCategories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _selectedCategories == null ? _title : _selectedCategories!,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              IconlyLight.buy,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 80,
            color: Colors.grey.shade300,
            child: FirestoreListView<Category>(
              query: categoryCollection,
              itemBuilder: (context, snapshot) {
                Category category = snapshot.data();
                return InkWell(
                  onTap: (() {
                    setState(() {
                      _title = category.catName;
                      _selectedCategories = category.catName;
                    });
                  }),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: CachedNetworkImage(
                            imageUrl: category.image,
                            color: _selectedCategories == category.catName
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          category.catName,
                          style: TextStyle(
                              fontSize: 10,
                              color: _selectedCategories == category.catName
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade700),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          MainCategoryWidget(selectedCat: _selectedCategories),
        ],
      ),
    );
  }
}
