import 'package:codehero/app/home/data/datasource/characters_datasource.dart';
import 'package:codehero/app/home/ui/cubit/home_cubit.dart';
import 'package:codehero/app/home/ui/cubit/pagination_cubit.dart';
import 'package:codehero/app/home/domain/repositories/character_repository.dart';
import 'package:codehero/app/home/ui/page/home_page.dart';
import 'package:codehero/app/profile/profile_module.dart';
import 'package:codehero/config/bloc_config.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<HomeCubit>(HomeCubit.new, config: blocConfig());
    i.add<PaginationCubit>(PaginationCubit.new);
    i.add<CharactersRepository>(CharactersDatasource.new);
  }

  @override
  List<Module> get imports => [ProfileModule()];

  @override
  void routes(r) {
    r.child("/", child: (context) => const HomePage());
    r.module('/profile', module: ProfileModule());
  }
}
