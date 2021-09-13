part of 'models.dart';

// ignore: must_be_immutable
class ProductModel extends Equatable {
  final String id;
  final String name;
  final String size;
  final String grade;
  final String category;
  final String description;
  final List<String> gallery;
  int qty;
  final int price;
  final int priceFlashSale;
  final bool isFlashSale;
  final bool isBestSeller;
  final Timestamp createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.size,
    required this.grade,
    required this.category,
    required this.description,
    required this.gallery,
    required this.qty,
    required this.price,
    required this.priceFlashSale,
    required this.isFlashSale,
    required this.isBestSeller,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> gallery = List.from(json['gallery']);

    return ProductModel(
      id: json['id'],
      name: json['name'],
      size: json['size'],
      grade: json['grade'],
      category: json['category'],
      description: json['description'],
      gallery: gallery,
      qty: json['qty'] as int,
      price: json['price'] as int,
      priceFlashSale: json['priceFlashSale'] as int,
      isFlashSale: json['isFlashSale'],
      isBestSeller: json['isBestSeller'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'grade': grade,
      'category': category,
      'createdAt': createdAt,
      'description': description,
      'gallery': List.from(gallery),
      'qty': qty,
      'price': price,
      'priceFlashSale': priceFlashSale,
      'isFlashSale': isFlashSale,
      'isBestSeller': isBestSeller,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        size,
        grade,
        category,
        description,
        gallery,
        price,
        priceFlashSale,
        isFlashSale,
        isBestSeller,
      ];
}
