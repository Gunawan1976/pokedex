import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemons_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPokemonsUseCase getPokemonsUseCase;

  HomeBloc({required this.getPokemonsUseCase}) : super(HomeInitial()) {
    on<GetPokemonsEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final pokemons = await getPokemonsUseCase();
        emit(HomeLoaded(
          allPokemons: pokemons,
          displayPokemons: pokemons,
        ));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<SearchPokemonsEvent>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        final filtered = _filterPokemons(
          currentState.allPokemons,
          event.query,
          currentState.selectedType,
        );
        emit(currentState.copyWith(
          searchQuery: event.query,
          displayPokemons: filtered,
        ));
      }
    });

    on<FilterTypeEvent>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        final filtered = _filterPokemons(
          currentState.allPokemons,
          currentState.searchQuery,
          event.type,
        );
        emit(currentState.copyWith(
          selectedType: event.type,
          clearSelectedType: event.type == null,
          displayPokemons: filtered,
        ));
      }
    });
  }

  List<PokemonEntity> _filterPokemons(
    List<PokemonEntity> pokemons,
    String query,
    String? type,
  ) {
    return pokemons.where((pokemon) {
      final matchesQuery = pokemon.name.toLowerCase().contains(query.toLowerCase());
      final matchesType = type == null ||
          pokemon.typeOfPokemon.any((t) => t.toLowerCase() == type.toLowerCase());
      return matchesQuery && matchesType;
    }).toList();
  }
}
