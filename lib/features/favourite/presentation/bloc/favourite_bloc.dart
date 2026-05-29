import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_favourites_usecase.dart';
import '../../domain/usecases/save_favourites_usecase.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final GetFavouritesUseCase getFavouritesUseCase;
  final SaveFavouritesUseCase saveFavouritesUseCase;

  FavouriteBloc({
    required this.getFavouritesUseCase,
    required this.saveFavouritesUseCase,
  }) : super(FavouriteLoaded([])) {
    on<LoadFavouritesEvent>((event, emit) async {
      try {
        final favourites = await getFavouritesUseCase();
        emit(FavouriteLoaded(favourites));
      } catch (_) {
        emit(FavouriteLoaded([]));
      }
    });

    on<ToggleFavouriteEvent>((event, emit) async {
      if (state is FavouriteLoaded) {
        final currentFavourites = List<PokemonEntity>.from((state as FavouriteLoaded).favourites);
        
        final isAlreadyFavourite = currentFavourites.any((p) => p.id == event.pokemon.id);
        
        if (isAlreadyFavourite) {
          currentFavourites.removeWhere((p) => p.id == event.pokemon.id);
        } else {
          currentFavourites.add(event.pokemon);
        }
        
        emit(FavouriteLoaded(currentFavourites));
        
        try {
          await saveFavouritesUseCase(currentFavourites);
        } catch (_) {
          // Fallback or logging could be added here
        }
      }
    });
  }
}
