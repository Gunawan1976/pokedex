import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_color.dart';
import '../../../shared/widget/pokemon_card.dart';
import '../../favourite/presentation/bloc/favourite_bloc.dart';
import '../domain/entities/pokemon_entity.dart';
import 'bloc/home_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PokedexScreen();
  }
}

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  // Dummy data sebagai fallback
  final List<PokemonEntity> dummyPokemons = [
    const PokemonEntity(
      id: '0',
      name: 'Aggron',
      imageUrl: 'assets/aggron.png',
      xDescription: '',
      height: '',
      weight: '',
      category: '',
      typeOfPokemon: ['Metal', 'Terrestrial'],
      weaknesses: const [],
      evolutions: const [],
      abilities: const [],
      malePercentage: '',
      femalePercentage: '',
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    ),
    const PokemonEntity(
      id: '0',
      name: 'Beedrill',
      imageUrl: 'assets/beedrill.png',
      xDescription: '',
      height: '',
      weight: '',
      category: '',
      typeOfPokemon: ['Insect', 'Poisonous'],
      weaknesses: const [],
      evolutions: const [],
      abilities: const [],
      malePercentage: '',
      femalePercentage: '',
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    ),
    const PokemonEntity(
      id: '0',
      name: 'Blastoise',
      imageUrl: 'assets/blastoise.png',
      xDescription: '',
      height: '',
      weight: '',
      category: '',
      typeOfPokemon: ['Water'],
      weaknesses: const [],
      evolutions: const [],
      abilities: const [],
      malePercentage: '',
      femalePercentage: '',
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    ),
    const PokemonEntity(
      id: '0',
      name: 'Bulbasaur',
      imageUrl: 'assets/bulbasaur.png',
      xDescription: '',
      height: '',
      weight: '',
      category: '',
      typeOfPokemon: ['Grass', 'Poisonous'],
      weaknesses: const [],
      evolutions: const [],
      abilities: const [],
      malePercentage: '',
      femalePercentage: '',
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    ),
    const PokemonEntity(
      id: '0',
      name: 'Chandelure',
      imageUrl: 'assets/chandelure.png',
      xDescription: '',
      height: '',
      weight: '',
      category: '',
      typeOfPokemon: ['Ghost', 'Fire'],
      weaknesses: const [],
      evolutions: const [],
      abilities: const [],
      malePercentage: '',
      femalePercentage: '',
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    ),
    const PokemonEntity(
      id: '0',
      name: 'Charmander',
      imageUrl: 'assets/charmander.png',
      xDescription: '',
      height: '',
      weight: '',
      category: '',
      typeOfPokemon: ['Fire'],
      weaknesses: const [],
      evolutions: const [],
      abilities: const [],
      malePercentage: '',
      femalePercentage: '',
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    ),
  ];

  void _showFilterBottomSheet(BuildContext context, HomeLoaded state) {
    final homeBloc = context.read<HomeBloc>();
    
    // Extract unique types from all pokemons
    final Set<String> uniqueTypes = {};
    for (var pokemon in state.allPokemons) {
      uniqueTypes.addAll(pokemon.typeOfPokemon);
    }
    
    final typesList = uniqueTypes.toList()..sort();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Text(
                  'Select Type',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: typesList.length + 1, // +1 for "All Type"
                  itemBuilder: (listContext, index) {
                    if (index == 0) {
                      return ListTile(
                        title: const Text('All Type'),
                        trailing: state.selectedType == null 
                            ? const Icon(Icons.check, color: Colors.blue) 
                            : null,
                        onTap: () {
                          homeBloc.add(FilterTypeEvent(null));
                          Navigator.pop(bottomSheetContext);
                        },
                      );
                    }
                    final type = typesList[index - 1];
                    return ListTile(
                      title: Text(type),
                      trailing: state.selectedType == type 
                          ? const Icon(Icons.check, color: Colors.blue) 
                          : null,
                      onTap: () {
                        homeBloc.add(FilterTypeEvent(type));
                        Navigator.pop(bottomSheetContext);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 16.0.h),
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5.w),
                ),
                child: TextField(
                  onChanged: (value) {
                    context.read<HomeBloc>().add(SearchPokemonsEvent(value));
                  },
                  decoration: InputDecoration(
                    hintText: 'Find the Pokemon',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 24.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Filter Button
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  String filterLabel = 'All Type';
                  bool isFiltered = false;
                  if (state is HomeLoaded && state.selectedType != null) {
                    filterLabel = state.selectedType!;
                    isFiltered = true;
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (state is HomeLoaded) {
                              _showFilterBottomSheet(context, state);
                            }
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: AppColors.allType,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filterLabel,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                ),
                                SizedBox(width: 8.w),
                                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20.sp),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isFiltered) ...[
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () {
                            context.read<HomeBloc>().add(FilterTypeEvent(null));
                          },
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(Icons.close, color: Colors.white, size: 20.sp),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              SizedBox(height: 24.h),

              // Pokemon List
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<PokemonEntity> displayPokemons = [];

                    if (state is HomeLoaded) {
                      displayPokemons = state.displayPokemons;
                      
                      if (displayPokemons.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada Pokemon yang ditemukan.'),
                        );
                      }
                    } else if (state is HomeError) {
                      displayPokemons = dummyPokemons;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal memuat data: ${state.message}')),
                        );
                      });
                    } else if (state is HomeInitial) {
                      displayPokemons = dummyPokemons;
                    }

                    return ListView.separated(
                      itemCount: displayPokemons.length,
                      separatorBuilder: (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final pokemon = displayPokemons[index];
                        return BlocBuilder<FavouriteBloc, FavouriteState>(
                          builder: (context, favState) {
                            bool isFav = false;
                            if (favState is FavouriteLoaded) {
                              isFav = favState.isFavourite(pokemon.id);
                            }
                            return PokemonCard(
                              pokemon: pokemon,
                              isFavourite: isFav,
                              onFavouriteTap: () {
                                context.read<FavouriteBloc>().add(ToggleFavouriteEvent(pokemon));
                                ScaffoldMessenger.of(context).clearSnackBars();
                                if (!isFav) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${pokemon.name} ditambahkan ke Favourite!'),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${pokemon.name} dihapus dari Favourite.'),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
