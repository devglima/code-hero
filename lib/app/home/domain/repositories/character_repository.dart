import 'package:codehero/app/home/domain/models/characters.dart';

abstract class CharactersRepository {
  Future<CharacterDataWrapper> getHeroes(
      {required int limit, required int offset, String? name});
}
