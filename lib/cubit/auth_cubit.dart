import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mechaku_blocs/models/models.dart';
import 'package:mechaku_blocs/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signUp(
          name: name, email: email, username: username, password: password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user =
          await AuthService().signIn(email: email, password: password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signInWithGoogle() async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signInWithGoogle();

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      emit(AuthLoading());

      UserModel user = await UserService().getUserById(id);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
