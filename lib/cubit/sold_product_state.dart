part of 'sold_product_cubit.dart';

abstract class SoldProductState extends Equatable {
  const SoldProductState();

  @override
  List<Object> get props => [];
}

class SoldProductInitial extends SoldProductState {}

class SoldProductLoading extends SoldProductState {}

class SoldProductSuccess extends SoldProductState {
  final SoldProductModel soldProduct;

  SoldProductSuccess(this.soldProduct);

  @override
  List<Object> get props => [soldProduct];
}

class SoldProductError extends SoldProductState {
  final String error;

  SoldProductError(this.error);

  @override
  List<Object> get props => [error];
}
