import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant.dart';
import 'logging_interceptor.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_pokemons_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

import '../../features/favourite/data/datasources/favourite_local_datasource.dart';
import '../../features/favourite/data/repositories/favourite_repository_impl.dart';
import '../../features/favourite/domain/repositories/favourite_repository.dart';
import '../../features/favourite/domain/usecases/get_favourites_usecase.dart';
import '../../features/favourite/domain/usecases/save_favourites_usecase.dart';
import '../../features/favourite/presentation/bloc/favourite_bloc.dart';

final locator = GetIt.instance;

/// Fungsi setup tunggal untuk DI
Future<void> setupLocator() async {
  final dio = await _createDio();

  // Register dependencies
  locator.registerLazySingleton<Dio>(() => dio);
  locator.registerLazySingleton<LoggingInterceptors>(
        () => LoggingInterceptors(dio: dio),
  );
  locator.registerLazySingleton(() => const FlutterSecureStorage());

  setupDependencies();
}

Future<Dio> _createDio() async {
  final options = BaseOptions(
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    baseUrl: Constant.BASE_URL,
  );

  final dio = Dio(options);

  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient(context: SecurityContext(withTrustedRoots: false));
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    },
    validateCertificate: (certificate, host, port) => true,
  );

  dio.interceptors.add(LoggingInterceptors(dio: dio,));

  return dio;
}


Future<void> setupDependencies() async {
  // Data sources
  locator.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(secureStorage: locator()),
  );
  locator.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dio: locator()),
  );
  locator.registerLazySingleton<FavouriteLocalDataSource>(
    () => FavouriteLocalDataSourceImpl(secureStorage: locator()),
  );

  // Repositories
  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<FavouriteRepository>(
    () => FavouriteRepositoryImpl(localDataSource: locator()),
  );

  // Use cases
  locator.registerLazySingleton(() => GetPokemonsUseCase(locator()));
  locator.registerLazySingleton(() => GetFavouritesUseCase(locator()));
  locator.registerLazySingleton(() => SaveFavouritesUseCase(locator()));

  // Blocs
  locator.registerFactory(() => HomeBloc(getPokemonsUseCase: locator()));
  locator.registerFactory(() => FavouriteBloc(
    getFavouritesUseCase: locator(),
    saveFavouritesUseCase: locator(),
  ));
}