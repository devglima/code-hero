import 'package:codehero/config/api.dart';
import 'package:codehero/app/home/domain/models/characters.dart';
import 'package:codehero/app/home/domain/repositories/character_repository.dart';

class CharactersDatasource implements CharactersRepository {
  @override
  Future<CharacterDataWrapper> getHeroes(
      {int limit = 4, required int offset, String? name}) async {
    try {
      Map<String, dynamic> query = {
        'limit': limit,
        'offset': offset,
      };

      if (name != "" && name != null) {
        query.addAll({
          'nameStartsWith': name,
        });
      }

      var result = await api.get("/characters", queryParameters: query);

      if (result.data['code'] == 200) {
        var data = CharacterDataWrapper.fromJson(result.data);

        return data;
      } else {
        throw Exception(result.data['status']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
