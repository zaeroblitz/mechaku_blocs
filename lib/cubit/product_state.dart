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

class ProductFlashSale extends ProductState {
  final List<ProductModel> products;

  ProductFlashSale(this.products);

  @override
  List<Object> get props => [products];
}

class ProductByName extends ProductState {
  final List<ProductModel> products;

  ProductByName(this.products);

  @override
  List<Object> get props => [products];
}

class ProductByCategory extends ProductState {
  final List<ProductModel> products;

  ProductByCategory(this.products);

  @override
  List<Object> get props => [products];
}

class ProductByLimit extends ProductState {
  final List<ProductModel> products;

  ProductByLimit(this.products);

  @override
  List<Object> get props => [products];
}

class ProductFailed extends ProductState {
  final String error;

  ProductFailed(this.error);

  @override
  List<Object> get props => [error];
}
