import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/widget/pokemon_card.dart';
import 'bloc/favourite_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Liked Pokemons', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 16.0.h),
          child: BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              if (state is FavouriteLoaded) {
                final favourites = state.favourites;

                if (favourites.isEmpty) {
                  return Center(
                    child: Text(
                      'Belum ada Pokemon favorit.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: favourites.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final pokemon = favourites[index];
                    return PokemonCard(
                      pokemon: pokemon,
                      isFavourite: true,
                      onFavouriteTap: () {
                        context.read<FavouriteBloc>().add(ToggleFavouriteEvent(pokemon));
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${pokemon.name} dihapus dari Favourite.'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
