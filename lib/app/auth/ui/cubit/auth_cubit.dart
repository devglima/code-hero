import 'package:bloc/bloc.dart';
import 'package:codehero/app/profile/domain/models/profile.dart';
import 'package:codehero/app/profile/view/cubit/settings_cubit.dart';
import 'package:codehero/config/db_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part '../../domain/states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await dbHelper.getLoginUser(email, password);

      final ProfileCubit profileCubit = Modular.get<ProfileCubit>();

      profileCubit.setUserProfile(user!);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
