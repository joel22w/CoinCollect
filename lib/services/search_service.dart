import 'package:coincollect/components/product_listing.dart';
import 'package:coincollect/components/search_card.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/models/products_model.dart';
import 'package:coincollect/provider/product_provider.dart';
import 'package:coincollect/screens/product/product_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

class Search {
  searchQueryPage(
      {required BuildContext context,
      required List<Products> products,
      required String address,
      DocumentSnapshot? sellerDetails,
      required ProductProvider provider}) {
    showSearch(
      context: context,
      delegate: SearchPage<Products>(
          barTheme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: whiteColour,
                  elevation: 0,
                  surfaceTintColor: primaryColour,
                  iconTheme: IconThemeData(color: blackColour),
                  actionsIconTheme: IconThemeData(color: blackColour))),
          onQueryUpdate: (s) => print(s),
          items: products,
          searchLabel: 'Search for an item',
          suggestion: const SingleChildScrollView(child: ProductListing()),
          failure: const Center(
            child: Text('No product found, Please check and try again..'),
          ),
          filter: (product) => [
                product.title,
                product.description,
                product.category,
                product.subcategory,
              ],
          builder: (product) {
            return InkWell(
                onTap: () {
                  provider.setProductDetails(product.document);
                  provider.setSellerDetails(sellerDetails);
                  Navigator.pushNamed(context, ProductDetail.screenId);
                },
                child: SearchCard(
                  product: product,
                  address: address,
                ));
          }),
    );
  }
}
