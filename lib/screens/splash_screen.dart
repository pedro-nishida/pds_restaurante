import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer for 3 seconds
    Timer(
      const Duration(seconds: 3),
      // After the timer is complete, this function will run
      () {
        // Use pushReplacement to go to the WelcomeScreen.
        // This prevents the user from being able to navigate back to the splash screen.
        if (mounted) { // Check if the widget is still in the tree
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A purple background to match your app's theme
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IMPORTANT: Make sure you have this image in your project
            // and have declared it in pubspec.yaml
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
              // Add a fallback in case the image fails to load
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.store,
                  size: 150,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

