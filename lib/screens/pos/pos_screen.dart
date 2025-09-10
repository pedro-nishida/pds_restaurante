import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../api/api_service.dart';
import 'widgets/product_grid.dart';
import 'widgets/cart_panel.dart';
import '../../widgets/base_scaffold.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      // Using mock data for now
      products = ApiService.getMockProducts();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading products: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'POS System',
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                ProductGrid(products: products),
                const CartPanel(),
              ],
            ),
    );
  }
}
