part of 'models.dart';

class CategoryArgument {
  final CategoryModel category;
  final List<ProductModel> products;

  CategoryArgument({
    required this.category,
    required this.products,
  });
}
