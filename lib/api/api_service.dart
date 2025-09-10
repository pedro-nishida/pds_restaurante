import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-url.com/api';
  
  // Headers for API requests
  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Products API
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
  static List<Product> getMockProducts() {
    return [
      Product(id: '1', name: 'Pizza Margherita', price: 25.0, description: 'Deliciosa pizza com molho de tomate e queijo.', imageUrl: 'https://example.com/pizza.jpg'),
      Product(id: '2', name: 'Hambúrguer Clássico', price: 18.0, description: 'Hambúrguer suculento com queijo e bacon.', imageUrl: 'https://example.com/burger.jpg'),
      Product(id: '3', name: 'Salada Caesar', price: 15.0, description: 'Salada fresca com frango grelhado e molho Caesar.', imageUrl: 'https://example.com/salad.jpg'),
    ];
  }
}
