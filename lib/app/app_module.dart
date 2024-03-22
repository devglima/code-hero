import 'package:codehero/app/data/datasource/characters_datasource.dart';
import 'package:codehero/app/domain/cubit/home_cubit.dart';
import 'package:codehero/app/domain/cubit/pagination_cubit.dart';
import 'package:codehero/app/domain/repositories/character_repository.dart';
import 'package:codehero/app/ui/page/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addInstance<Dio>(Dio());
    i.add<HomeCubit>(HomeCubit.new);
    i.add<PaginationCubit>(PaginationCubit.new);
    i.add<CharactersRepository>(CharactersDatasource.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
  }
}
