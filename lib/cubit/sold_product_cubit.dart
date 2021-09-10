import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mechaku_blocs/models/models.dart';
import 'package:mechaku_blocs/services/services.dart';

part 'sold_product_state.dart';

class SoldProductCubit extends Cubit<SoldProductState> {
  SoldProductCubit() : super(SoldProductInitial());

  void addSoldProduct(List<SoldProductModel> soldProduct) async {
    try {
      emit(SoldProductLoading());

      soldProduct.map((e) => SoldProductService().addSoldProduct(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}
