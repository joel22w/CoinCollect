import 'package:coincollect/components/product_listing.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  static const String screenId = 'product_by_category';
  const ProductByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColour,
          iconTheme: IconThemeData(
            color: blackColour,
          ),
          title: Text(
            (categoryProvider.selectedSubCategory == null)
                ? 'note'
                : '${categoryProvider.selectedCategory} ${categoryProvider.selectedCategory == 'note' ? '' : '> ${categoryProvider.selectedSubCategory}'}',
            style: TextStyle(
              color: blackColour,
            ),
          ),
        ),
        body: const SingleChildScrollView(
            child: ProductListing(
          isProductByCategory: true,
        )));
  }
}
