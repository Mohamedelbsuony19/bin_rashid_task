import 'package:bin_rashid_task_app/data/models/product_model.dart';
import 'package:bin_rashid_task_app/data/repos/product_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.dart';
part 'products_event.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
    final ProductRepo repo;

  ProductsBloc(this.repo) : super(const ProductsState.initial()) {
    on<ProductsEvent>((event, emit) async {
      await event.maybeMap(
        orElse: () {},
        getProductById: (value)async {},
        getProducts: (value)async {
          emit(const ProductsState.loadInProgress());
          final products = await repo.getProducts();
          if (products.isEmpty) {
            emit(const ProductsState.loadFailure());
            return;
          }
          
          emit(ProductsState.loadSuccess(products: products));
        },
      );
    });
  }
}
