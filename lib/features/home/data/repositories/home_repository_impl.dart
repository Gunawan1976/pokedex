import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<PokemonEntity>> getPokemons() async {
    // 1. Try fetching from local cache
    final cachedPokemons = await localDataSource.getCachedPokemons();
    if (cachedPokemons != null && cachedPokemons.isNotEmpty) {
      return cachedPokemons;
    }

    // 2. If no cache, fetch from remote
    final remotePokemons = await remoteDataSource.getPokemons();
    
    // 3. Save remote data to local cache
    await localDataSource.cachePokemons(remotePokemons);

    return remotePokemons;
  }
}
