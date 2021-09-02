part of 'product_new_arrival_cubit.dart';

abstract class ProductNewArrivalState extends Equatable {
  const ProductNewArrivalState();

  @override
  List<Object> get props => [];
}

class ProductNewArrivalInitial extends ProductNewArrivalState {}

class ProductNewArrivalLoading extends ProductNewArrivalState {}

class ProductNewArrivalSuccess extends ProductNewArrivalState {
  final List<ProductModel> products;

  ProductNewArrivalSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductNewArrivalFailed extends ProductNewArrivalState {
  final String error;

  ProductNewArrivalFailed(this.error);

  @override
  List<Object> get props => [error];
}
