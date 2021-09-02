import '../models/models.dart';
import 'package:bloc/bloc.dart';
import '../services/services.dart';
import 'package:equatable/equatable.dart';

part 'product_new_arrival_state.dart';

class ProductNewArrivalCubit extends Cubit<ProductNewArrivalState> {
  ProductNewArrivalCubit() : super(ProductNewArrivalInitial());

  // Get New Arrival Products
  void getNewArrivalProducts() async {
    try {
      emit(ProductNewArrivalLoading());

      List<ProductModel> products =
          await ProductService().getNewArrivalProducts();

      emit(ProductNewArrivalSuccess(products));
    } catch (e) {
      emit(ProductNewArrivalFailed(e.toString()));
    }
  }
}
