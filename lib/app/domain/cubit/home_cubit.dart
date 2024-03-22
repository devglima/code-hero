import 'package:bloc/bloc.dart';
import 'package:codehero/app/data/models/characters.dart';
import 'package:codehero/app/domain/repositories/character_repository.dart';
import 'package:equatable/equatable.dart';

part '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CharactersRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  void fetchHeroes({int limit = 4, required int offset, String? name}) async {
    try {
      emit(HomeLoading());
      final heroes =
          await repository.getHeroes(limit: limit, offset: offset, name: name);
      emit(HomeSuccess(heroes));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
