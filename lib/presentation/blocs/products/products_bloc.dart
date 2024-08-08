import 'package:bin_rashid_task_app/data/models/product_model.dart'; // Import the ProductModel class.
import 'package:bin_rashid_task_app/data/repos/product_repo.dart'; // Import the ProductRepo class for fetching products.
import 'package:bloc/bloc.dart'; // Import the BLoC package for state management.
import 'package:freezed_annotation/freezed_annotation.dart'; // Import Freezed for union types and sealed classes.

part 'products_bloc.freezed.dart'; // Part directive for the Freezed-generated code.
part 'products_event.dart'; // Part directive for the ProductsEvent.
part 'products_state.dart'; // Part directive for the ProductsState.

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  // Reference to the repository that handles product data fetching
  final ProductRepo repo;

  // A private list to hold all fetched products for easy access and filtering
  List<ProductModel>? _allProducts;

  // Constructor for the ProductsBloc, initializing with an initial state
  ProductsBloc(this.repo) : super(const ProductsState.initial()) {
    // Event handler for ProductsBloc
    on<ProductsEvent>((event, emit) async {
      await event.maybeMap(
        orElse: () {}, // Default case, does nothing

        // Handles the event to fetch all products
        getProducts: (value) async {
          // Emit a loading state while fetching the products
          emit(const ProductsState.loadInProgress());

          // Fetch products from the repository
          final products = await repo.getProducts();

          // If no products are found, emit a failure state
          if (products.isEmpty) {
            emit(const ProductsState.loadFailure());
            return;
          }

          // Store the fetched products in _allProducts
          _allProducts = products;

          // Emit a success state with the fetched products
          emit(ProductsState.loadSuccess(products: products));
        },

        // Handles the event to search products based on a query
        searchProducts: (value) async {
          // If products have not been fetched yet, return early
          if (_allProducts == null) {
            return;
          }

          // Filter the products based on the search query (case-insensitive)
          final filteredProducts = _allProducts!
              .where((product) => product.title
                  .toLowerCase()
                  .contains(value.query.toLowerCase()))
              .toList();

          // Emit a success state with the filtered products
          emit(ProductsState.loadSuccess(products: filteredProducts));
        },
      );
    });
  }
}
