import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isInitialized = false;
  
  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  
  ThemeProvider() {
    _loadThemePreference();
  }
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreference();
    notifyListeners();
  }
  
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    _saveThemePreference();
    notifyListeners();
  }
  
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      // Se não conseguir carregar, usa o tema claro como padrão
      _isDarkMode = false;
      _isInitialized = true;
      notifyListeners();
    }
  }
  
  Future<void> _saveThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode);
    } catch (e) {
      // Ignora erros de salvamento
    }
  }
}
