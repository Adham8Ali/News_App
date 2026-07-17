import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/cubit/auth_states.dart';
import 'package:news_app/features/auth/data/auth_data_source.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthDataSource dataSource = AuthDataSource();

  UserModel? currentUser;

  AuthCubit(AuthDataSource authDataSource) : super(AuthInitial());

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());

    try {
      await dataSource.signUp(email, password, name);
      emit(AuthSignUpSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      UserModel userData = await dataSource.login(email, password);

      currentUser = userData;

      emit(AuthloginSuccess(user: userData));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await dataSource.logout();

      currentUser = null;

      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
