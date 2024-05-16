import 'package:bloc/bloc.dart';
import 'package:codehero/app/profile/domain/models/profile.dart';
import 'package:codehero/app/profile/view/cubit/settings_cubit.dart';
import 'package:codehero/config/db_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part '../../domain/states/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final ProfileCubit profileCubit = Modular.get<ProfileCubit>();

  void register(String name, String email, String password) async {
    try {
      emit(RegisterLoading());

      final user = await dbHelper.saveData(
        Profile(
          user_name: name,
          email: email,
          password: password,
        ),
      );

      profileCubit.setUserProfile(Profile(
        user_name: name,
        email: email,
        password: password,
      ));

      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
