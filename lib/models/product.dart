/// Represents a product from the restaurant's menu.
class Product {
  final String id; // A unique identifier for the product (e.g., 'coffee-01')
  final String name;
  final double price;
  final String? description;
  final String? category;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.category,
    this.imageUrl,
  });

  // Convert Product to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  // Create Product from JSON response
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
    );
  }
}
