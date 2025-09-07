import 'dart:convert';
import 'package:get/get.dart'; // Make sure this is in pubspec.yaml
import '../models/store.dart';
import 'package:http/http.dart' as http; // Make sure this is in pubspec.yaml

class StoreRepository {
  final String serverUrl = '10.0.2.2:3000/store';

  Future<Store?> registerStore({required Store store}) async { // Changed to Future<Store?>
    final response = await http.post(
      Uri.parse('$serverUrl/registerStore'), // Corrected URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'storeName': store.storeName,
        'storeAddress': store.storeAddress,
        'storeLatitude': store.storeLatitude,
        'storeLongitude': store.storeLongitude,
        'storePhone': store.storePhone,
        'storeEmail': store.storeEmail,
        'storePassword': store.storePassword,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData['message'];
      Get.snackbar('Registration', message);
      // Assuming the server sends back the registered store or relevant info
      // If server sends back the store:
      // return Store.fromJson(responseData['store']); // Or however it's structured
      // For now, returning null as original code didn't return a store
      return null; // Or throw Exception('Failed to get store from response');
    } else if (response.statusCode == 500) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData['message'];
      Get.snackbar('Registration', message);
      return null; // Or throw Exception(message);
    } else {
      Get.snackbar('Registration', 'Something went wrong. Status: ${response.statusCode}');
      return null; // Or throw Exception('Something went wrong');
    }
  }

  Future<Store?> loginStore({required String email, required String password}) async { // Changed to Future<Store?>
    final response = await http.post(
      Uri.parse('$serverUrl/loginStore'), // Corrected URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'storeEmail': email,
        'storePassword': password,
      }),
    ); // Corrected syntax here

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Assuming responseData['store'] exists and is the store object
      if (responseData.containsKey('store')) {
        final store = Store.fromJson(responseData['store']);
        return store;
      } else {
        Get.snackbar('Login Error', 'Store data not found in response.');
        return null; // Or throw Exception('Store data not found in response');
      }
    } else if (response.statusCode == 401) {
      Get.snackbar('Login Failed', 'Invalid credentials.'); // Provide user feedback
      return null;
    } else {
      Get.snackbar('Login Error', 'Error logging in. Status: ${response.statusCode}');
      // Consider logging response.body for debugging
      // throw Exception('Failed to login. Status: ${response.statusCode}');
      return null;
    }
  }
}
