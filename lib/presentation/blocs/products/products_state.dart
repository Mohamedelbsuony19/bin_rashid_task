part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loadInProgress() = _LoadInProgress;
  const factory ProductsState.loadSuccess({List<ProductModel>? products , ProductModel? product}) = _LoadSuccess;
  const factory ProductsState.loadFailure({String? message}) = _LoadFailure;
}