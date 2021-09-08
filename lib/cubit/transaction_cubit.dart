import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mechaku_blocs/models/models.dart';
import 'package:mechaku_blocs/services/services.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void setTransaction(TransactionModel transactionModel) async {
    try {
      await TransactionService().setTransaction(transactionModel);
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void getTransaction(String userID) async {
    try {
      emit(TransactionLoading());

      List<TransactionModel> transactions =
          await TransactionService().getTransaction(userID);

      transactions.sort((transaction1, transaction2) =>
          transaction2.time.compareTo(transaction1.time));

      emit(TransactionSuccess(transactions));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
