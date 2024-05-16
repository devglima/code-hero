part of '../../ui/cubit/password_visibility_cubit.dart';

class PasswordVisibilityState extends Equatable {
  final bool isVisible;

  PasswordVisibilityState(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class ConfirmPasswordVisibilityState extends PasswordVisibilityState {
  ConfirmPasswordVisibilityState(bool isVisible) : super(isVisible);
}
