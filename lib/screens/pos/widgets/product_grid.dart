import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../models/product.dart';
import '../../../utils/app_theme.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  
  const ProductGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Aumentado de 3 para 4 (itens menores)
          childAspectRatio: 0.75, // Ajustado para itens mais compactos
          crossAxisSpacing: AppDimensions.paddingS,
          mainAxisSpacing: AppDimensions.paddingS,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: AppDimensions.elevationS, // Menor elevação
            child: InkWell(
              onTap: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    duration: const Duration(milliseconds: 800),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.only(
                      bottom: 80,
                      left: 20,
                      right: 20,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ícone da categoria
                    Icon(
                      _getCategoryIcon(product.category),
                      size: 24, // Diminuído de 32 para 24
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    
                    // Nome do produto
                    Flexible(
                      child: Text(
                        product.name,
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 11),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    
                    // Preço
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.priceText.copyWith(fontSize: 12),
                    ),
                    
                    // Descrição (se houver)
                    if (product.description != null && product.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          product.description!,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 9),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'beverages':
      case 'drinks':
        return Icons.local_drink;
      case 'food':
      case 'main':
        return Icons.restaurant;
      case 'dessert':
      case 'desserts':
        return Icons.cake;
      case 'coffee':
        return Icons.local_cafe;
      case 'snacks':
        return Icons.fastfood;
      default:
        return Icons.shopping_bag;
    }
  }
}
