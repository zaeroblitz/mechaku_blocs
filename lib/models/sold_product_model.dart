part of 'models.dart';

class SoldProductModel extends Equatable {
  final ProductModel product;
  final String userID;
  final String transactionID;
  final int qty;
  final int subTotal;
  final int shipmentPrice;
  final int totalPrice;

  SoldProductModel({
    required this.product,
    required this.userID,
    required this.transactionID,
    required this.qty,
    required this.subTotal,
    required this.shipmentPrice,
    required this.totalPrice,
  });

  factory SoldProductModel.fromJson(Map<String, dynamic> json) =>
      SoldProductModel(
        product: ProductModel.fromJson(json['product']),
        userID: json['userID'],
        transactionID: json['transactionID'],
        qty: json['qty'],
        subTotal: json['subTotal'],
        shipmentPrice: json['shipmentPrice'],
        totalPrice: json['totalPrice'],
      );

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'userID': userID,
      'transactionID': transactionID,
      'qty': qty,
      'subTotal': subTotal,
      'shipmentPrice': shipmentPrice,
      'totalPrice': totalPrice,
    };
  }

  @override
  List<Object?> get props => [
        product,
        userID,
        transactionID,
        qty,
        subTotal,
        shipmentPrice,
        totalPrice,
      ];
}
