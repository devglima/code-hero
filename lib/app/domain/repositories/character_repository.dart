import 'package:codehero/app/data/models/characters.dart';

abstract class CharactersRepository {
  Future<CharacterDataWrapper> getHeroes(
      {required int limit, required int offset, String? name});
}
