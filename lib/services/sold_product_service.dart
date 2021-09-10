part of 'services.dart';

class SoldProductService {
  CollectionReference _soldProductRef =
      FirebaseFirestore.instance.collection('sold_products');

  Future<void> addSoldProduct(SoldProductModel soldProduct) async {
    try {
      await _soldProductRef.add(soldProduct.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<List<SoldProductModel>> getAllSoldProducts() async {
    try {
      QuerySnapshot snapshot = await _soldProductRef.get();
      List<SoldProductModel> soldProducts = snapshot.docs.map((doc) {
        return SoldProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return soldProducts;
    } catch (e) {
      throw e;
    }
  }

  Future<List<SoldProductModel>> getSoldProductsUser(String userID) async {
    try {
      QuerySnapshot snapshot =
          await _soldProductRef.where('userID', isEqualTo: userID).get();
      List<SoldProductModel> soldProducts = snapshot.docs.map((doc) {
        return SoldProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return soldProducts;
    } catch (e) {
      throw e;
    }
  }
}
