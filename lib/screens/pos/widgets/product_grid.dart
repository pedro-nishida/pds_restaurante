import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../models/product.dart';
import '../../../utils/app_theme.dart';

/// Widget responsivo que exibe produtos em um grid adaptativo
/// 
/// Breakpoints de responsividade:
/// - < 600px (Smartphones): 2 colunas
/// - 600-900px (Tablets pequenos): 3 colunas  
/// - 900-1200px (Tablets grandes): 4 colunas
/// - > 1200px (Desktops): 5 colunas
///
/// Ajustes automáticos:
/// - Tamanhos de fonte maiores em smartphones
/// - Ícones maiores em telas pequenas
/// - Padding e spacing reduzidos em smartphones
/// - Mais linhas de texto para descrição em smartphones
class ProductGrid extends StatelessWidget {
  final List<Product> products;
  
  const ProductGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // Obter o tamanho da tela
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Determinar o número de colunas baseado na largura da tela
    int crossAxisCount;
    double childAspectRatio;
    
    if (screenWidth < 600) {
      // Smartphones: 2 colunas
      crossAxisCount = 1;
      childAspectRatio = 0.8;
    } else if (screenWidth < 900) {
      // Tablets pequenos: 3 colunas
      crossAxisCount = 3;
      childAspectRatio = 0.75;
    } else if (screenWidth < 1200) {
      // Tablets grandes: 4 colunas
      crossAxisCount = 4;
      childAspectRatio = 0.75;
    } else {
      // Desktops: 5 colunas
      crossAxisCount = 5;
      childAspectRatio = 0.7;
    }
    
    // Ajustar padding e spacing baseado no tamanho da tela
    final padding = screenWidth < 600 ? AppDimensions.paddingS : AppDimensions.paddingM;
    final spacing = screenWidth < 600 ? AppDimensions.paddingXS : AppDimensions.paddingS;
    
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(padding),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
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
              },
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ícone da categoria (responsivo)
                    Icon(
                      _getCategoryIcon(product.category),
                      size: screenWidth < 600 ? 28 : 24, // Maior em smartphones
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    
                    // Nome do produto (responsivo)
                    Flexible(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: screenWidth < 600 ? 13 : 11, // Maior em smartphones
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    
                    // Preço (responsivo)
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: screenWidth < 600 ? 14 : 12, // Maior em smartphones
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // Descrição (se houver) - responsiva
                    if (product.description != null && product.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          product.description!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: screenWidth < 600 ? 10 : 9, // Maior em smartphones
                          ),
                          textAlign: TextAlign.center,
                          maxLines: screenWidth < 600 ? 2 : 1, // Mais linhas em smartphones
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
