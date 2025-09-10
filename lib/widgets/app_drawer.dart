import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.restaurant_menu, size: 48, color: Theme.of(context).colorScheme.onPrimary),
                const SizedBox(height: 8),
                Text('Restaurante POS', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.point_of_sale),
            title: const Text('PDV'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/pos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Menu'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/menu');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Checkout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/checkout');
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/dashboard');
            },
          ),
        ],
      ),
    );
  }
}
