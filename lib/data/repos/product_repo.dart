import 'dart:convert';

import 'package:bin_rashid_task_app/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  static const String baseUrl = 'fakestoreapi.com';

  Future<List<ProductModel>> getProducts() async {
    var uri = Uri.https(
      baseUrl,
      '/products',
    );
    final response = await http.get(uri);
    try {
      final json = jsonDecode(response.body) as List<dynamic>;
      var productResponse = json.map((e) => ProductModel.fromJson(e));
      return productResponse.toList();
    } catch (e) {
      rethrow;
    }
  }
}
