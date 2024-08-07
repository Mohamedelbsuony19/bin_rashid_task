import 'package:bin_rashid_task_app/presentation/blocs/products/products_bloc.dart';
import 'package:bin_rashid_task_app/presentation/ui/screens/product_details_screen.dart';
import 'package:bin_rashid_task_app/presentation/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(children: [
        BlocConsumer<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return state.maybeMap(
                orElse: () => Container(),
                loadInProgress: (value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loadSuccess: (value) {
                  if (value.products == null) {
                    return const Center(
                      child: Text("No Products Found"),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                      itemCount: value.products?.length,
                      itemBuilder: (context, index) {
                        final product = value.products?[index];
                        return ProductItemView(
                          model: product!,
                          onTap: () {
                            ///navigate to product details
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsScreen(model: product)));
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
            listener: (context, state) => Container()),
      ]),
    );
  }
}
