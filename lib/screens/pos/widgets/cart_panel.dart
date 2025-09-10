import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../utils/app_theme.dart';
import '../../checkout/checkout_screen.dart';

class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Diminuído de 300 para 250
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(left: BorderSide(color: AppColors.greyLight)),
      ),
      child: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              // Header do carrinho
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceVariant,
                  border: Border(bottom: BorderSide(color: AppColors.greyLight)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Order',
                      style: Theme.of(context).textTheme.headlineMedium, // Menor
                    ),
                    if (cart.items.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          cart.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cart cleared!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Lista de itens
              Expanded(
                child: cart.items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 40, // Menor
                              color: AppColors.grey,
                            ),
                            const SizedBox(height: AppDimensions.paddingS),
                            Text(
                              'No items',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingS,
                        ),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final cartItem = cart.items[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingS,
                              vertical: 2,
                            ),
                            padding: const EdgeInsets.all(AppDimensions.paddingS),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nome do produto
                                Text(
                                  cartItem.product.name,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                
                                // Preço unitário
                                Text(
                                  '\$${cartItem.product.price.toStringAsFixed(2)} each',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                                ),
                                const SizedBox(height: AppDimensions.paddingXS),
                                
                                // Controles de quantidade e total
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Controles de quantidade
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cart.removeSingleItem(cartItem.product.id);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: AppColors.error.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 14,
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 6),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: Text(
                                            '${cartItem.quantity}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cart.addItem(cartItem.product);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: AppColors.success.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 14,
                                              color: AppColors.success,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Total do item
                                    Text(
                                      '\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontSize: 12,
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              
              // Footer com total e checkout
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.greyLight)),
                ),
                child: Column(
                  children: [
                    // Totais
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items: ${cart.totalItemCount}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.priceGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    
                    // Botão de checkout
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cart.items.isEmpty
                            ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const CheckoutScreen(),
                                    ),
                                  );
                                },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: Text(
                          'Checkout',
                          style: TextStyle(fontSize: 14),
                        ),
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
