import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '../../domain/states/password_visibility_state.dart';

class VisibilityCubit extends Cubit<PasswordVisibilityState> {
  VisibilityCubit(bool initialState)
      : super(PasswordVisibilityState(initialState));

  void toggleVisibility() {
    emit(PasswordVisibilityState(!state.isVisible));
  }
}

class PasswordVisibilityCubit extends VisibilityCubit {
  PasswordVisibilityCubit() : super(false);
}

class ConfirmPasswordVisibilityCubit extends VisibilityCubit {
  ConfirmPasswordVisibilityCubit() : super(false);
}
