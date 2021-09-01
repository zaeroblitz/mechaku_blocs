import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mechaku_blocs/models/models.dart';
import 'package:mechaku_blocs/services/services.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void getCategories() async {
    try {
      emit(CategoryLoading());

      List<CategoryModel> categories = await CategoryService().getCategories();

      emit(CategorySuccess(categories));
    } on FirebaseException catch (e) {
      emit(CategoryFailed(e.message.toString()));
    } catch (e) {
      emit(CategoryFailed(e.toString()));
    }
  }
}
