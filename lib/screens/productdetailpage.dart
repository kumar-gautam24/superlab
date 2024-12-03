import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; 

class ProductDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  const ProductDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(thumbnail, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: ₹${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            HtmlWidget(description),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Purchase'),
                    content: Text('You are about to buy $title for ₹$price'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                         
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Purchase successful!')),
                          );
                        },
                        child: const Text('Confirm Purchase'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), 
                ),
                elevation: 5,
              ),
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}

