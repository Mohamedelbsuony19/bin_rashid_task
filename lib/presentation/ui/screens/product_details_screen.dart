import 'package:bin_rashid_task_app/data/models/product_model.dart';
import 'package:bin_rashid_task_app/main.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel model;

  const ProductDetailsScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(model.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Image.network(
                    model.image,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                model.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                '\$${model.price}',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.green),
              ),
              const SizedBox(height: 10),
              Text(
                model.category,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                model.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
