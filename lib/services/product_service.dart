part of 'services.dart';

class ProductService {
  CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  // Get All Products
  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _productRef.orderBy('name').get();

      List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return products;
    } catch (e) {
      throw e;
    }
  }

  // Get Random Products
  Future<List<ProductModel>> getLimitProducts(int limit) async {
    try {
      QuerySnapshot snapshot = await _productRef.limit(limit).get();
      List<ProductModel> products = snapshot.docs.map((e) {
        return ProductModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList();

      return products;
    } catch (e) {
      throw e;
    }
  }

  // Get Best Seller Products
  Future<List<ProductModel>> getBestSellerProducts() async {
    try {
      QuerySnapshot snapshot =
          await _productRef.where('isBestSeller', isEqualTo: true).get();

      List<ProductModel> bestSellerProducts = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return bestSellerProducts;
    } catch (e) {
      throw e;
    }
  }

  // Get Flash Sale Products
  Future<List<ProductModel>> getFlashSaleProducts() async {
    try {
      QuerySnapshot snapshot = await _productRef
          .where('isFlashSale', isEqualTo: true)
          .orderBy('name')
          .get();

      List<ProductModel> bestSellerProducts = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return bestSellerProducts;
    } catch (e) {
      throw e;
    }
  }

  // Get New Arrival Products
  Future<List<ProductModel>> getNewArrivalProducts() async {
    try {
      QuerySnapshot snapshot =
          await _productRef.orderBy('createdAt').limit(5).get();

      List<ProductModel> bestSellerProducts = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return bestSellerProducts;
    } catch (e) {
      throw e;
    }
  }

  // Get Products by Name
  Future<List<ProductModel>> getProductsByName(String name) async {
    try {
      QuerySnapshot snapshot = await _productRef
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThanOrEqualTo: name + '\uf8ff')
          .get();

      List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return products;
    } catch (e) {
      throw e;
    }
  }

  // Get Products by Category
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      QuerySnapshot snapshot =
          await _productRef.where('category', isEqualTo: category).get();

      List<ProductModel> bestSellerProducts = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return bestSellerProducts;
    } catch (e) {
      throw e;
    }
  }

  // Update Product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productRef.doc(product.id).update(product.toJson());
    } catch (e) {
      throw e;
    }
  }
}
