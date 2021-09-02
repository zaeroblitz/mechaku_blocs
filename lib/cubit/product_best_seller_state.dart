part of 'product_best_seller_cubit.dart';

abstract class ProductBestSellerState extends Equatable {
  const ProductBestSellerState();

  @override
  List<Object> get props => [];
}

class ProductBestSellerInitial extends ProductBestSellerState {}

class ProductBestSellerLoading extends ProductBestSellerState {}

class ProductBestSellerSuccesss extends ProductBestSellerState {
  final List<ProductModel> products;

  ProductBestSellerSuccesss(this.products);

  @override
  List<Object> get props => [products];
}

class ProductBestSellerFailed extends ProductBestSellerState {
  final String error;

  ProductBestSellerFailed(this.error);

  @override
  List<Object> get props => [error];
}
