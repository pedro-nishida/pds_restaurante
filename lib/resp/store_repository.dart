import 'dart:convert';
import 'package:get/get.dart';
import '../models/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository{
  final String serverUrl = '10.0.2.2:3000/store';

  Future<Store> registerStore({required Store store}) async{
    final response = await http.post(Uri.parse('serverUrl/registerStore'), headers: {
      'Content-Type': 'application/json'
    },
        body: jsonEncode({
          'storeName': store.storeName,
          'storeAddress': store.storeAddress,
          'storeLatitude': store.storeLatitude,
          'storeLongitude': store.storeLongitude,
          'storePhone': store.storePhone,
          'storeEmail': store.storeEmail,
          'storePassword': store.storePassword
        }),
        );
    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData['message'];
      Get.snackbar('Registration', message);
    }
    else if(response.statusCode == 500){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String message = responseData['message'];
      Get.snackbar('Registration', message);
    }
    else{
      Get.snackbar('Registration', 'Something went wrong');
    }
  }
  Future<Store> loginStore({required String email, required String password}) async{
    final response = await http.post(Uri.parse('serverUrl/loginStore'), headers: {
      'Content-Type': 'application/json'
    },
        body: jsonEncode({
          'storeEmail': email,
          'storePassword': password
        }),
  };
  if(response.statusCode == 200){
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final store = Store.fromJson(responseData['store']);
    return store;
  }
  else if(response.statusCode == 401){
    return null;
  }
  else{
    Get.snackbar('Login Error', 'Error logging in'););
    throw Exception('Failed to login');
  }

}