import 'dart:async';

import 'package:bin_rashid_task_app/presentation/blocs/products/products_bloc.dart'; // Import the ProductsBloc.
import 'package:bin_rashid_task_app/presentation/ui/screens/product_details_screen.dart'; // Import the ProductDetailsScreen.
import 'package:bin_rashid_task_app/presentation/ui/widgets/connection_internet_widget.dart';
import 'package:bin_rashid_task_app/presentation/ui/widgets/product_item.dart'; // Import the ProductItemView widget.
import 'package:flutter/material.dart'; // Import Flutter's material design widgets.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'; // Import Flutter Bloc for state management.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController to handle the search input field
  final TextEditingController _searchController = TextEditingController();
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
    // Dispose the controller when the widget is disposed to free up resources
    _searchController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == InternetStatus.connected
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Home Screen"), // AppBar title
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                    48.0), // Set the height for the search bar
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller:
                        _searchController, // Attach the controller to the search field
                    decoration: const InputDecoration(
                      hintText:
                          'Search Products...', // Placeholder text in the search field
                      prefixIcon: Icon(Icons
                          .search), // Search icon at the start of the field
                      border:
                          OutlineInputBorder(), // Outline border for the text field
                    ),
                    // Trigger search when the user types in the search field
                    onChanged: (query) {
                      context
                          .read<ProductsBloc>()
                          .add(ProductsEvent.searchProducts(query));
                    },
                  ),
                ),
              ),
            ),
            // Use BlocConsumer to listen and build the UI based on the ProductsBloc state
            body: BlocConsumer<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  // Handle different states using maybeMap
                  return state.maybeMap(
                      orElse: () =>
                          Container(), // Default empty container if no state matches

                      // Show loading spinner when products are being loaded
                      loadInProgress: (value) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },

                      // Display the list of products when loading is successful
                      loadSuccess: (value) {
                        if (value.products == null || value.products!.isEmpty) {
                          return const Center(
                            child: Text(
                                "No Products Found"), // Show this if no products are found
                          );
                        }
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: ListView.builder(
                            itemCount: value.products
                                ?.length, // Number of items in the list
                            itemBuilder: (context, index) {
                              final product = value.products?[index];
                              return ProductItemView(
                                model:
                                    product!, // Pass the product model to the ProductItemView
                                onTap: () {
                                  // Navigate to the product details screen when a product is tapped
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                  model: product)));
                                },
                              );
                            },
                          ),
                        );
                      },

                      // Show error message if product loading fails
                      loadFailure: (value) {
                        return const Center(
                          child: Scaffold(
                            body: Center(
                              child: Text(
                                  "There was an error"), // Display error message
                            ),
                          ),
                        );
                      });
                },
                // Listener for state changes (not used here but kept for structure)
                listener: (context, state) => Container()),
          )
        : NoInternetConnectionScreen(
            onRetry: () {},
          );
  }
}
