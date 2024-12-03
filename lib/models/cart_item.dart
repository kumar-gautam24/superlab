class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  const CartItem(
      {required this.name,
      required this.price,
      required this.id,
      required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
