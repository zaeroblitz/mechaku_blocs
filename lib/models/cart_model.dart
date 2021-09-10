part of 'models.dart';

// ignore: must_be_immutable
class CartModel extends Equatable {
  final ProductModel product;
  int qty;
  int totalPrice;

  CartModel({
    required this.product,
    required this.qty,
    required this.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        product: ProductModel.fromJson(json['product']),
        qty: json['qty'],
        totalPrice: json['totalPrice'],
      );

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'qty': qty,
      'totalPrice': totalPrice,
    };
  }

  @override
  List<Object?> get props => [];
}
