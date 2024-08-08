import 'package:bin_rashid_task_app/data/repos/product_repo.dart'; // Import the ProductRepo class.
import 'package:bin_rashid_task_app/presentation/blocs/products/products_bloc.dart'; // Import the ProductsBloc.
import 'package:bin_rashid_task_app/presentation/ui/screens/home_screen.dart'; // Import the HomeScreen widget.
import 'package:flutter/material.dart'; // Import Flutter's material design widgets.
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc for state management.

void main() {
  runApp(const MainApp()); // Start the application by running MainApp.
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the ProductsBloc to the widget tree
      create: (context) =>
          ProductsBloc(ProductRepo())..add(const ProductsEvent.getProducts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable the debug banner
        theme: ThemeData(
          useMaterial3: true, // Use Material 3 design specifications
        ),
        home: const HomeScreen(), // Set HomeScreen as the home widget
      ),
    );
  }
}
