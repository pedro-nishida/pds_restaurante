import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../models/product.dart';
import '../../utils/app_theme.dart';
import '../cart/cart_screen.dart';

// A mock product list. In a real app, you would fetch this from your backend.
final List<Product> mockProducts = [
  Product(id: 'prod_001', name: 'Espresso', price: 5.50),
  Product(id: 'prod_002', name: 'Cappuccino', price: 8.00),
  Product(id: 'prod_003', name: 'Croissant', price: 7.25),
  Product(id: 'prod_004', name: 'Cheesecake', price: 12.00),
  Product(id: 'prod_005', name: 'Mineral Water', price: 3.00),
  Product(id: 'prod_006', name: 'Orange Juice', price: 6.50),
];

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We use a Consumer to get the cart and display the item count in the badge
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Menu'),
            actions: [
              // This is the shopping cart icon with a badge
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // Navigate to the CartScreen when the cart icon is tapped
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                  ),
                  // The badge showing the number of items
                  if (cart.totalItemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.cartBadge,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          cart.totalItemCount.toString(),
                          style: AppTextStyles.cartBadgeText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            // Use a grid with 2 columns. Adjust crossAxisCount for different layouts.
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimensions.gridSpacing,
              mainAxisSpacing: AppDimensions.gridSpacing,
              childAspectRatio: 3 / 2, // Adjust aspect ratio for item size
            ),
            itemCount: mockProducts.length,
            itemBuilder: (ctx, i) {
              final product = mockProducts[i];
              return Card(
                elevation: AppDimensions.elevationM,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
                child: InkWell(
                  onTap: () {
                    // Add item to cart when the card is tapped
                    Provider.of<CartProvider>(context, listen: false).addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.cardTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.paddingS),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.priceText.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}