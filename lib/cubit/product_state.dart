part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductFailed extends ProductState {
  final String error;

  ProductFailed(this.error);

  @override
  List<Object> get props => [error];
}
