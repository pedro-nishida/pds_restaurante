import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../utils/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return cart.items.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        cart.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cart cleared!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text(
                        'Clear All',
                        style: TextStyle(color: AppColors.onPrimary),
                      ),
                    )
                  : Container();
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: AppDimensions.paddingM),
                  Text(
                    'Your cart is empty',
                    style: AppTextStyles.headline3,
                  ),
                  SizedBox(height: AppDimensions.paddingS),
                  Text(
                    'Add some items to get started!',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.paddingM),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.product.name,
                                    style: AppTextStyles.cardTitle,
                                  ),
                                  const SizedBox(height: AppDimensions.paddingXS),
                                  Text(
                                    '\$${cartItem.product.price.toStringAsFixed(2)} each',
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cart.removeSingleItem(cartItem.product.id);
                                  },
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: AppColors.error,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.paddingS,
                                    vertical: AppDimensions.paddingXS,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceVariant,
                                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                                  ),
                                  child: Text(
                                    '${cartItem.quantity}',
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cart.addItem(cartItem.product);
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                            const SizedBox(width: AppDimensions.paddingS),
                            Text(
                              '\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                              style: AppTextStyles.priceText,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.greyLight),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Items: ${cart.totalItemCount}',
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                          style: AppTextStyles.priceText.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cart.items.isEmpty
                            ? null
                            : () {
                                // TODO: Implement checkout functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checkout functionality coming soon!'),
                                  ),
                                );
                              },
                        child: const Text('Proceed to Checkout'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
