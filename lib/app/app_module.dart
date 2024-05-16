import 'package:codehero/app/auth/auth_module.dart';
import 'package:codehero/app/home/home_module.dart';
import 'package:codehero/app/profile/profile_module.dart';
import 'package:codehero/app/profile/view/cubit/settings_cubit.dart';
import 'package:codehero/config/bloc_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addInstance<Dio>(Dio());
    i.addSingleton<ProfileCubit>(
      ProfileCubit.new,
      config: blocConfig(),
    );
  }

  @override
  void routes(r) {
    r.module("/auth", module: AuthModule());
    r.module("/profile", module: ProfileModule());
    r.module("/home", module: HomeModule());
  }
}
