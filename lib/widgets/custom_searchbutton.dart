import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../screens/productdetailpage.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> products; 

  CustomSearchDelegate({required this.products});

  static const String iimage =
      'https://media.istockphoto.com/id/1021908014/photo/word-writing-text-free-sample-business-concept-for-portion-of-products-given-to-consumers-in.webp?s=2048x2048&w=is&k=20&c=DJ_ISzjoE0CseFdjdEheJ62XtPllJx0tR_reNV3yOFw=';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    final matchResult = products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchResult.length,
      itemBuilder: (context, index) {
        final product = matchResult[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text(product.price.toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  title: product.title,
                  description: product.description,
                  price: product.price,
                  thumbnail: iimage,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    final matchResult = products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchResult.length,
      itemBuilder: (context, index) {
        final product = matchResult[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text(product.price.toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  title: product.title,
                  description: product.description,
                  price: product.price,
                  thumbnail: iimage,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
