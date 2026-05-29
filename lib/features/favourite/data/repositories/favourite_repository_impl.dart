import '../../../home/data/models/pokemon_model.dart';
import '../../../home/domain/entities/pokemon_entity.dart';
import '../../domain/repositories/favourite_repository.dart';
import '../datasources/favourite_local_datasource.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteLocalDataSource localDataSource;

  FavouriteRepositoryImpl({required this.localDataSource});

  @override
  Future<List<PokemonEntity>> getFavourites() async {
    return await localDataSource.getFavourites();
  }

  @override
  Future<void> saveFavourites(List<PokemonEntity> favourites) async {
    final models = favourites.map((e) => PokemonModel(
      id: e.id,
      name: e.name,
      imageUrl: e.imageUrl,
      xDescription: e.xDescription,
      height: e.height,
      weight: e.weight,
      category: e.category,
      typeOfPokemon: e.typeOfPokemon,
      weaknesses: e.weaknesses,
      evolutions: e.evolutions,
      abilities: e.abilities,
      malePercentage: e.malePercentage,
      femalePercentage: e.femalePercentage,
      hp: e.hp,
      attack: e.attack,
      defense: e.defense,
      specialAttack: e.specialAttack,
      specialDefense: e.specialDefense,
      speed: e.speed,
    )).toList();
    
    await localDataSource.cacheFavourites(models);
  }
}
