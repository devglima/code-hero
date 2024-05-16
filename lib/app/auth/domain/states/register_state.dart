part of '../../ui/cubit/register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Profile user;

  RegisterSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);

  @override
  List<Object> get props => [error];
}
