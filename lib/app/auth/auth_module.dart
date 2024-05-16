import 'package:codehero/app/auth/ui/cubit/auth_cubit.dart';
import 'package:codehero/app/auth/ui/cubit/password_visibility_cubit.dart';
import 'package:codehero/app/auth/ui/cubit/register_cubit.dart';
import 'package:codehero/app/auth/ui/view/login_view.dart';
import 'package:codehero/app/auth/ui/view/register_view.dart';
import 'package:codehero/app/auth/ui/view/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(AuthCubit.new);
    i.add<RegisterCubit>(RegisterCubit.new);
    i.add<PasswordVisibilityCubit>(PasswordVisibilityCubit.new);
    i.add<ConfirmPasswordVisibilityCubit>(ConfirmPasswordVisibilityCubit.new);
  }

  @override
  void routes(r) {
    r.child("/splash",
        child: (context) => const Splash(), transition: TransitionType.fadeIn);
    r.child("/login",
        child: (context) => LoginBlocFirebaseWidget(),
        transition: TransitionType.fadeIn);
    r.child("/register",
        child: (context) => RegisterBlocFirebaseWidget(),
        transition: TransitionType.fadeIn);
  }
}
