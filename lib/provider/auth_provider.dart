import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Login method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Mock user for now
      if (email == "admin@restaurant.com" && password == "admin123") {
        _currentUser = User(
          id: "1",
          name: "Admin User",
          email: email,
          role: UserRole.admin,
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Invalid email or password";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Login failed: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout method
  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Check if user has permission for certain actions
  bool hasPermission(String action) {
    if (_currentUser == null) return false;
    
    switch (action) {
      case 'manage_orders':
        return _currentUser!.role == UserRole.admin || 
               _currentUser!.role == UserRole.manager;
      case 'manage_products':
        return _currentUser!.role == UserRole.admin;
      case 'view_reports':
        return _currentUser!.role == UserRole.admin || 
               _currentUser!.role == UserRole.manager;
      default:
        return true; // Basic actions allowed for all authenticated users
    }
  }
}
