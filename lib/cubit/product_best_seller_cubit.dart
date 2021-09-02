import 'package:bloc/bloc.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'package:equatable/equatable.dart';

part 'product_best_seller_state.dart';

class ProductBestSellerCubit extends Cubit<ProductBestSellerState> {
  ProductBestSellerCubit() : super(ProductBestSellerInitial());

  // Get Best Seller Products
  void getBestSellerProducts() async {
    try {
      emit(ProductBestSellerLoading());

      List<ProductModel> products =
          await ProductService().getBestSellerProducts();

      emit(ProductBestSellerSuccesss(products));
    } catch (e) {
      emit(ProductBestSellerFailed(e.toString()));
    }
  }
}
