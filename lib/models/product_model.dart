class Product {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final int inventoryQuantity;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.inventoryQuantity,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      inventoryQuantity: json['variants'][0]['inventoryQuantity'] ?? 0,
      price: json['variants'][0]['price']?.toDouble() ?? 0.0,
    );
  }

  bool get isInStock => inventoryQuantity > 0;
}
