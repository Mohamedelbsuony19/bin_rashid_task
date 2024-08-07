import 'package:bin_rashid_task_app/data/repos/product_repo.dart';
import 'package:bin_rashid_task_app/presentation/blocs/products/products_bloc.dart';
import 'package:bin_rashid_task_app/presentation/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsBloc(ProductRepo())..add(const ProductsEvent.getProducts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
