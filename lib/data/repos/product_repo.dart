import 'dart:convert'; // Used for decoding JSON data.

import 'package:bin_rashid_task_app/data/models/product_model.dart'; // Import the ProductModel class.
import 'package:http/http.dart'
    as http; // Import the http package for making network requests.

class ProductRepo {
  // Base URL for the API
  static const String baseUrl = 'fakestoreapi.com';

  // Method to fetch products from the API
  Future<List<ProductModel>> getProducts() async {
    // Construct the URI for the API request
    var uri = Uri.https(
      baseUrl,
      '/products', // Endpoint for fetching products
    );

    // Make a GET request to the API
    final response = await http.get(uri);

    try {
      // Decode the response body as a List of dynamic objects
      final json = jsonDecode(response.body) as List<dynamic>;

      // Map each dynamic object to a ProductModel and return the list
      var productResponse = json.map((e) => ProductModel.fromJson(e));

      // Convert the iterable to a List and return it
      return productResponse.toList();
    } catch (e) {
      // If there's an error, rethrow it to be handled by the caller
      rethrow;
    }
  }
}
