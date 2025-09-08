import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'provider/cart_provider.dart';
import 'provider/auth_provider.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        // Add other providers here as your app grows
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant POS',
      theme: AppTheme.lightTheme,
      // Set the SplashScreen as the initial route of the app
      home: const SplashScreen(),
    );
  }
}

