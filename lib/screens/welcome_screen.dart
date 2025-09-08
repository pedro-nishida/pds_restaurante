import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pds_restaurante/provider/cart_provider.dart'; // Import the provider

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the Consumer widget to listen for changes in the CartProvider
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // The 'cart' variable is the instance of your CartProvider
        return Scaffold(
          appBar: AppBar(
            title: const Text('POS Home'),
            // Display the number of items in the cart in the AppBar
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // You could navigate to a cart screen here
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cart.items.length.toString(), // This now shows number of unique products
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.point_of_sale, size: 80, color: Colors.deepPurple),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to your Flutter POS System!',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Display the current total from the cart
                Text(
                  'Cart Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  // When pressed, call the addItem method from the provider
                  onPressed: () {
                    // 1. Create a Product instance
                    // You'll need a unique ID for the product.
                    // For this example, let's use a placeholder.
                    // In a real app, this ID would come from your backend or a product database.
                    final productToAdd = Product(id: 'coffee_001', name: 'Coffee', price: 2.50);

                    // 2. Call addItem with the Product instance
                    Provider.of<CartProvider>(context, listen: false).addItem(productToAdd);
                  },
                  child: const Text('Add Item to Cart'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

