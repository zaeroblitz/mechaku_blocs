part of 'models.dart';

class CategoryModel extends Equatable {
  final String name;
  final String banner;

  CategoryModel({
    required this.name,
    required this.banner,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json['name'], banner: json['banner']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'banner': banner,
    };
  }

  @override
  List<Object?> get props => [name, banner];
}
