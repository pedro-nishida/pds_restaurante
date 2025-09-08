import 'package:flutter/foundation.dart';

/// Represents a product from the restaurant's menu.
class Product {
  final String id; // A unique identifier for the product (e.g., 'coffee-01')
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

/// Represents a line item in the shopping cart.
/// It contains the product and the quantity being ordered.
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  // Use a Map to store cart items. The key is the Product's ID.
  // This makes it fast to check for and update existing items.
  final Map<String, CartItem> _items = {};

  // Public getter to access the cart items as a list for UI display.
  List<CartItem> get items => _items.values.toList();

  /// Adds a product to the cart.
  /// If the product is already in the cart, it increases the quantity.
  /// Otherwise, it adds a new CartItem with a quantity of 1.
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // If the item is already in the cart, just update its quantity.
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // If it's a new item, add it to the cart.
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product, quantity: 1),
      );
    }
    // Notify listeners to rebuild the UI.
    notifyListeners();
  }

  /// Decreases the quantity of a single item in the cart.
  /// If the quantity drops to zero, the item is removed completely.
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return; // Item not in cart, do nothing.
    }

    if (_items[productId]!.quantity > 1) {
      // If quantity is more than 1, just decrease it.
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      // If quantity is 1, remove the item from the cart entirely.
      _items.remove(productId);
    }
    notifyListeners();
  }

  /// Removes an entire line item from the cart, regardless of quantity.
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  /// Clears all items from the cart.
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// A computed property to get the total price of all items in the cart.
  /// It now correctly multiplies each item's price by its quantity.
  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  /// A computed property to get the total number of individual items in the cart.
  int get totalItemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }
}