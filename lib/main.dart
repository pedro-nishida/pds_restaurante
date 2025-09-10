import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'provider/cart_provider.dart';
import 'provider/auth_provider.dart';
import 'provider/theme_provider.dart';
import 'utils/app_theme.dart';
import 'screens/pos/pos_screen.dart';
import 'screens/orders/menu_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // Add other providers here as your app grows
      ],
        child: const MyApp(), // Keep the MyApp as the child of MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Mostra loading enquanto carrega as preferências
        if (!themeProvider.isInitialized) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        
        return MaterialApp(
          title: 'Restaurant POS',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: '/pos',
          routes: {
            '/pos': (context) => const PosScreen(),
            '/menu': (context) => const MenuScreen(),
            '/checkout': (context) => const CheckoutScreen(),
            '/dashboard': (context) => const DashboardScreen(),
          },
          // Set the SplashScreen as the initial route of the app
          home: const SplashScreen(),
        );
      },
    );
  }
}

