part of 'products_bloc.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.getProducts() = _GetProducts;

  const factory ProductsEvent.getProductById({required String productId}) = _GetProductById;
}