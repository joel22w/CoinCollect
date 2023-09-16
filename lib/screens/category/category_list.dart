import 'package:coincollect/provider/category_provider.dart';
import 'package:coincollect/screens/category/product_category.dart';
import 'package:coincollect/screens/category/subcategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../services/auth_service.dart';

class CategoryListScreen extends StatelessWidget {
  final bool? isForForm;
  static const String screenId = 'category_list_screen';

  const CategoryListScreen({Key? key, this.isForForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColour,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColour),
        title: Text(
          isForForm == true ? 'Select Category' : 'Categories',
          style: TextStyle(color: blackColour),
        ),
      ),
      body: _buildBody(context, categoryProvider), // Call the _buildBody method
    );
  }

  // Refactored the body of the widget into a separate method
  Widget _buildBody(BuildContext context, CategoryProvider categoryProvider) {
    Auth authService = Auth();

    return FutureBuilder<QuerySnapshot>(
      future: authService.categories.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(); // Placeholder for error handling
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: secondaryColour,
            ),
          ); // Display a loading while fetching data
        }

        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: ((context, index) {
            var doc = snapshot.data?.docs[index];
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  categoryProvider.setCategory(doc!['category_name']);
                  categoryProvider.setCategorySnapshot(doc);
                  if (isForForm == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => SubCategoryScreen(
                          doc: doc,
                          isForForm: true,
                        ),
                      ),
                    );
                  } else {
                    if (doc['subcategory'] == null) {
                      Navigator.of(context).pushNamed(ProductByCategory.screenId);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => SubCategoryScreen(
                            doc: doc,
                          ),
                        ),
                      );
                    }
                  }
                },
                leading: Image.network(doc!['img']),
                title: Text(
                  doc['category_name'],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                trailing: doc['subcategory'] != null
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      )
                    : null,
              ),
            );
          }),
        );
      },
    );
  }
}
