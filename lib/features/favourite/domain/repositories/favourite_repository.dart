import '../../../home/domain/entities/pokemon_entity.dart';

abstract class FavouriteRepository {
  Future<List<PokemonEntity>> getFavourites();
  Future<void> saveFavourites(List<PokemonEntity> favourites);
}
