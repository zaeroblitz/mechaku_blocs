import 'package:bloc/bloc.dart';

class TopUpCubit extends Cubit<int> {
  int currentBalanceSelected;
  bool isSelected;
  TopUpCubit(this.currentBalanceSelected, this.isSelected) : super(0);

  void setSelectedTopUp(int balance) => emit(currentBalanceSelected = balance);

  void isSelectedTopUp(int balance) {
    if (balance == currentBalanceSelected) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }
}
