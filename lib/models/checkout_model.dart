part of 'models.dart';

class CheckoutModel extends Equatable {
  final ProductModel product;
  final int qty;
  final int totalPrice;

  CheckoutModel({
    required this.product,
    required this.qty,
    required this.totalPrice,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
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
