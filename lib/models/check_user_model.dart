part of 'models.dart';

class CheckUserModel extends Equatable {
  final String email;
  CheckUserModel(this.email);

  @override
  List<Object?> get props => [email];
}
