import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../models/product.dart';
import '../../utils/app_theme.dart';
import '../cart/cart_screen.dart';
import '../../widgets/base_scaffold.dart';

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
    return BaseScaffold(
      title: 'Menu',
      onCartPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
      },
      body: GridView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimensions.gridSpacing,
          mainAxisSpacing: AppDimensions.gridSpacing,
          childAspectRatio: 3 / 2,
        ),
        itemCount: mockProducts.length,
        itemBuilder: (ctx, i) {
          final product = mockProducts[i];
          return Card(
            elevation: AppDimensions.elevationM,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
            child: InkWell(
              onTap: () {
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppTheme.priceGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
