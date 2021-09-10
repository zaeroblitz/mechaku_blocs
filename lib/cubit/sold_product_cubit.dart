import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mechaku_blocs/models/models.dart';
import 'package:mechaku_blocs/services/services.dart';

part 'sold_product_state.dart';

class SoldProductCubit extends Cubit<SoldProductState> {
  SoldProductCubit() : super(SoldProductInitial());

  void addSoldProduct(SoldProductModel soldProduct) async {
    try {
      emit(SoldProductLoading());

      await SoldProductService().addSoldProduct(soldProduct);
    } catch (e) {
      throw e;
    }
  }
}
