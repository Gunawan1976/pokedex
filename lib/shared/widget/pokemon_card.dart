import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/util_helper.dart';
import '../../features/home/domain/entities/pokemon_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

PokemonType mapPokemonType(String typeStr) {
  switch (typeStr.toLowerCase()) {
    case 'grass':
      return PokemonType(name: 'Grass', color: AppColors.grass, imagePath: 'lib/assets/grass.svg');
    case 'poison':
    case 'poisonous':
      return PokemonType(name: 'Poisonous', color: AppColors.poisonous, imagePath: 'lib/assets/poison.svg');
    case 'fire':
      return PokemonType(name: 'Fire', color: AppColors.fire, imagePath: 'lib/assets/fire.svg');
    case 'water':
      return PokemonType(name: 'Water', color: AppColors.water, imagePath: 'lib/assets/water.svg');
    case 'bug':
    case 'insect':
      return PokemonType(name: 'Insect', color: AppColors.insect, imagePath: 'lib/assets/bug.svg');
    case 'normal':
      return PokemonType(name: 'Normal', color: Colors.grey, imagePath: 'lib/assets/normal.svg');
    case 'flying':
      return PokemonType(name: 'Flying', color: Colors.lightBlue, imagePath: 'lib/assets/flying.svg');
    case 'electric':
      return PokemonType(name: 'Electric', color: Colors.yellow, imagePath: 'lib/assets/lightning.svg');
    case 'ground':
    case 'terrestrial':
      return PokemonType(name: 'Terrestrial', color: AppColors.terrestrial, imagePath: 'lib/assets/ground.svg');
    case 'ghost':
      return PokemonType(name: 'Ghost', color: AppColors.ghost, imagePath: 'lib/assets/ghost.svg');
    case 'metal':
    case 'steel':
      return PokemonType(name: 'Metal', color: AppColors.metal, imagePath: 'lib/assets/steel.svg');
    case 'ice':
      return PokemonType(name: 'Ice', color: Colors.cyan, icon: Icons.ac_unit);
    case 'psychic':
      return PokemonType(name: 'Psychic', color: Colors.pinkAccent, imagePath: 'lib/assets/psychic.svg');
    case 'fighting':
    case 'fighter':
      return PokemonType(name: 'Fighter', color: Colors.red, imagePath: 'lib/assets/fighting.svg');
    case 'dragon':
      return PokemonType(name: 'Dragon', color: Colors.deepPurple, imagePath: 'lib/assets/dragon.svg');
    case 'dark':
      return PokemonType(name: 'Dark', color: Colors.black54, imagePath: 'lib/assets/dark.svg');
    case 'fairy':
      return PokemonType(name: 'Fairy', color: Colors.pink, imagePath: 'lib/assets/fairy.svg');
    case 'rock':
      return PokemonType(name: 'Rock', color: Colors.brown, imagePath: 'lib/assets/rock.svg');
    default:
      return PokemonType(name: typeStr, color: Colors.grey, icon: Icons.help_outline);
  }
}

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  final bool isFavourite;
  final VoidCallback? onFavouriteTap;

  const PokemonCard({
    super.key, 
    required this.pokemon,
    this.isFavourite = false,
    this.onFavouriteTap,
  });

  Color _getPrimaryColor() {
    if (pokemon.typeOfPokemon.isNotEmpty) {
      return mapPokemonType(pokemon.typeOfPokemon.first).color;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/detail', extra: pokemon);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // Sentuhan tegas pada border
          border: Border.all(color: Colors.black87, width: 1.2.w),
        ),
      child: Row(
        children: [
          // Left Side - Details
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0.w, top: 12.0.h, bottom: 12.0.h, right: 8.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: pokemon.typeOfPokemon
                        .map((type) => TypeBadge(type: mapPokemonType(type)))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          // Right Side - Image & Background
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
              child: Container(
                color: _getPrimaryColor(),
                child: Stack(
                  children: [
                    // Pokemon Image
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.w),
                        // Fallback ke Icon jika image asset belum ada
                        child: pokemon.imageUrl.startsWith('http')
                            ? Image.network(
                                pokemon.imageUrl,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.catching_pokemon, size: 50.sp, color: Colors.white70),
                              )
                            : Image.asset(
                                pokemon.imageUrl,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.catching_pokemon, size: 50.sp, color: Colors.white70),
                              ),
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: onFavouriteTap,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5.w),
                            color: isFavourite ? Colors.white : Colors.transparent,
                          ),
                          child: Icon(
                            isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: isFavourite ? Colors.red : Colors.white,
                            size: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class TypeBadge extends StatelessWidget {
  final PokemonType type;
  final double? height;
  final double? width;

  const TypeBadge({super.key, required this.type, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: type.color, width: 1.5.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type.imagePath != null)
            SvgPicture.asset(
              type.imagePath!,
              width: 12.sp,
              height: 12.sp,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            )
          else if (type.icon != null)
            Icon(
              type.icon,
              color: Colors.white,
              size: 12.sp,
            ),
          SizedBox(width: 4.w),
          Text(
            type.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
