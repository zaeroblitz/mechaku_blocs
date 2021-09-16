import 'package:mechaku_blocs/services/services.dart';

import '../models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  // Get All Products
  void getProducts() async {
    try {
      emit(ProductLoading());

      List<ProductModel> products = await ProductService().getProducts();

      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  // Get Flash Sale Products
  void getFlashSaleProducts() async {
    try {
      emit(ProductLoading());

      List<ProductModel> products =
          await ProductService().getFlashSaleProducts();

      emit(ProductFlashSale(products));
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  // Get Products by Name
  void getProductsByName(String name) async {
    try {
      emit(ProductLoading());
      List<ProductModel> products =
          await ProductService().getProductsByName(name);
      emit(ProductByName(products));
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  // Get Products by Category
  void getProductsByCategory(String category) async {
    try {
      emit(ProductLoading());

      List<ProductModel> products =
          await ProductService().getProductsByCategory(category);

      emit(ProductByCategory(products));
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  // Get Products by Limit
  void getProductsByLimit(int limit) async {
    try {
      emit(ProductLoading());
      List<ProductModel> products =
          await ProductService().getLimitProducts(limit);

      emit(ProductByLimit(products));
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  // Update Product
  void updateProduct(ProductModel product) async {
    try {
      emit(ProductLoading());
      await ProductService().updateProduct(product);
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }
}
