import 'dart:async';

import 'package:bin_rashid_task_app/data/models/product_model.dart'; // Import the ProductModel class.
import 'package:bin_rashid_task_app/presentation/ui/widgets/connection_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'; // Import Flutter's material design widgets.

class ProductDetailsScreen extends StatefulWidget {
  // The product model to display details for
  final ProductModel model;

  const ProductDetailsScreen({
    super.key,
    required this.model, // Require the product model in the constructor
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // This variable stores the current internet connection status, initially set to 'connected'.
  InternetStatus _connectionStatus = InternetStatus.connected;

// This will be used to listen for changes in the internet connection status.
  late StreamSubscription<InternetStatus> _subscription;
  @override
  void initState() {
    // Subscribes to the internet connection status changes and updates the _connectionStatus variable
    // whenever a change occurs, triggering a UI update with setState.
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == InternetStatus.connected
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget
                  .model.title), // Display the product title in the AppBar
            ),
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(16.0), // Add padding around the content
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align children to the start
                children: [
                  Center(
                    child: Image.network(
                      widget.model.image, // Load and display the product image
                      fit: BoxFit.cover, // Cover the space proportionally
                      height: MediaQuery.of(context).size.height *
                          0.3, // Set height relative to screen
                      width: MediaQuery.of(context).size.width *
                          0.8, // Set width relative to screen
                    ),
                  ),
                  const SizedBox(height: 20), // Add vertical spacing
                  Text(
                    widget.model.title, // Display the product title
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall, // Use headline style
                  ),
                  const SizedBox(height: 10), // Add vertical spacing
                  Text(
                    '\$${widget.model.price}', // Display the product price
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.green), // Use green color for the price
                  ),
                  const SizedBox(height: 10), // Add vertical spacing
                  Text(
                    widget.model.category, // Display the product category
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey), // Use grey color for the category
                  ),
                  const SizedBox(height: 20), // Add vertical spacing
                  Text(
                    widget.model.description, // Display the product description
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge, // Use body text style
                  ),
                ],
              ),
            ),
          )
        : NoInternetConnectionScreen(
            onRetry: () {},
          );
  }
}
