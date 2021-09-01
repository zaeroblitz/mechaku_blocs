part of 'services.dart';

class CategoryService {
  CollectionReference _categoryRef =
      FirebaseFirestore.instance.collection('categories');

  Future<List<CategoryModel>> getCategories(int limit) async {
    try {
      QuerySnapshot snapshot;

      if (limit == 0) {
        snapshot = await _categoryRef.orderBy('name').get();
      } else {
        snapshot = await _categoryRef.orderBy('name').limit(limit).get();
      }

      List<CategoryModel> categories = snapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return categories;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await _categoryRef.add(category.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCategory(CategoryModel category, String id) async {
    try {
      await _categoryRef.doc(id).set(category.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _categoryRef.doc(id).delete();
    } catch (e) {
      throw e;
    }
  }
}
