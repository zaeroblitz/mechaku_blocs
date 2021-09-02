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
      throw e;
    }
  }

  // Get Best Seller Products
  void getBestSellerProducts() async {
    try {
      emit(ProductLoading());

      List<ProductModel> products =
          await ProductService().getBestSellerProducts();

      emit(ProductBestSeller(products));
    } catch (e) {
      throw e;
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
      throw e;
    }
  }

  // Get New Arrival Products
  void getNewArrivalProducts() async {
    try {
      emit(ProductLoading());

      List<ProductModel> products =
          await ProductService().getNewArrivalProducts();

      emit(ProductNewArrival(products));
    } catch (e) {
      throw e;
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
      throw e;
    }
  }
}
