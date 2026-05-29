import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/app_color.dart';
import '../../../shared/widget/pokemon_card.dart';
import '../../home/domain/entities/pokemon_entity.dart';
import '../../home/presentation/bloc/home_bloc.dart';
import '../../favourite/presentation/bloc/favourite_bloc.dart';

class DetailPokemonPage extends StatelessWidget {
  final PokemonEntity pokemon;

  const DetailPokemonPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final primaryColor = pokemon.typeOfPokemon.isNotEmpty
        ? mapPokemonType(pokemon.typeOfPokemon.first).color
        : Colors.grey;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header area with curved bottom and overlapping image
            SizedBox(
              height: 350.h,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 280.h,
                      color: primaryColor,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                            onPressed: () => context.pop(),
                          ),
                          BlocBuilder<FavouriteBloc, FavouriteState>(
                            builder: (context, state) {
                              bool isFav = false;
                              if (state is FavouriteLoaded) {
                                isFav = state.isFavourite(pokemon.id);
                              }
                              return IconButton(
                                icon: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.white,
                                  size: 24.sp,
                                ),
                                onPressed: () {
                                  context.read<FavouriteBloc>().add(ToggleFavouriteEvent(pokemon));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        height: 240.h,
                        width: 240.w,
                        child: pokemon.imageUrl.startsWith('http')
                            ? Image.network(pokemon.imageUrl, fit: BoxFit.contain)
                            : Image.asset(pokemon.imageUrl, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Column(
                children: [
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    children: pokemon.typeOfPokemon
                        .map((type) => TypeBadge(type: mapPokemonType(type)))
                        .toList(),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    pokemon.xDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87, height: 1.5),
                  ),
                  SizedBox(height: 32.h),

                  // Info Grid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoItem(title: 'Weight', value: pokemon.weight),
                      _InfoItem(title: 'Height', value: pokemon.height),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoItem(title: 'Category', value: pokemon.category),
                      _InfoItem(title: 'Ability', value: pokemon.abilities.isNotEmpty ? pokemon.abilities.first : '-'),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Gender
                  _SectionTitle('Gender'),
                  SizedBox(height: 12.h),
                  _GenderBar(male: pokemon.malePercentage, female: pokemon.femalePercentage),
                  SizedBox(height: 32.h),

                  // Weaknesses
                  if (pokemon.weaknesses.isNotEmpty) ...[
                    _SectionTitle('Weakness'),
                    SizedBox(height: 16.h),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 3.2,
                      ),
                      itemCount: pokemon.weaknesses.length,
                      itemBuilder: (context, index) {
                        final type = mapPokemonType(pokemon.weaknesses[index]);
                        return Container(
                          decoration: BoxDecoration(
                            color: type.color,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: type.imagePath != null
                                    ? SvgPicture.asset(
                                        type.imagePath!,
                                        width: 18.sp,
                                        height: 18.sp,
                                        colorFilter: ColorFilter.mode(type.color, BlendMode.srcIn),
                                      )
                                    : Icon(
                                        type.icon,
                                        color: type.color,
                                        size: 18.sp,
                                      ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                type.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                  ],

                  // Evolutions
                  if (pokemon.evolutions.isNotEmpty) ...[
                    _SectionTitle('Evolutions'),
                    SizedBox(height: 16.h),
                    _EvolutionsList(evolutionIds: pokemon.evolutions),
                    SizedBox(height: 40.h),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50.h);
    path.quadraticBezierTo(size.width / 2, size.height + 50.h, size.width, size.height - 50.h);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp)),
        SizedBox(height: 8.h),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 50.h,
            width: 150.w,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _GenderBar extends StatelessWidget {
  final String male;
  final String female;

  const _GenderBar({required this.male, required this.female});

  @override
  Widget build(BuildContext context) {
    if (male == '0%' && female == '0%' || male.isEmpty || female.isEmpty) {
      return Text('Gender Unknown', style: TextStyle(fontSize: 14.sp));
    }

    final double maleFlex = double.tryParse(male.replaceAll('%', '').trim()) ?? 50;
    final double femaleFlex = double.tryParse(female.replaceAll('%', '').trim()) ?? 50;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: maleFlex.toInt(),
              child: Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(4.r)),
                ),
              ),
            ),
            Expanded(
              flex: femaleFlex.toInt(),
              child: Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(4.r)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [Icon(Icons.male, color: Colors.blue, size: 16.sp), Text(' Male $male', style: TextStyle(fontSize: 14.sp))]),
            Row(children: [Text('Female $female ', style: TextStyle(fontSize: 14.sp)), Icon(Icons.female, color: Colors.pinkAccent, size: 16.sp)]),
          ],
        ),
      ],
    );
  }
}

class _EvolutionsList extends StatelessWidget {
  final List<String> evolutionIds;

  const _EvolutionsList({required this.evolutionIds});

  @override
  Widget build(BuildContext context) {
    if (evolutionIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final allPokemons = state.allPokemons;
          List<PokemonEntity> evos = [];
          for (var id in evolutionIds) {
            final match = allPokemons.where((p) => p.id == id);
            if (match.isNotEmpty) {
              evos.add(match.first);
            }
          }

          if (evos.isEmpty) return Text('Evolution data not found', style: TextStyle(fontSize: 14.sp));

          return Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey.shade200, width: 1.5.w),
            ),
            child: Column(
              children: List.generate(evos.length, (index) {
                final evo = evos[index];
                final primaryColor = evo.typeOfPokemon.isNotEmpty
                    ? mapPokemonType(evo.typeOfPokemon.first).color
                    : Colors.grey;

                return Column(
                  children: [
                    if (index > 0)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                        child: Icon(
                          Icons.arrow_downward,
                          size: 36.sp,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.r),
                        border: Border.all(color: Colors.grey.shade300, width: 1.w),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: evo.imageUrl.startsWith('http')
                                  ? Image.network(evo.imageUrl, fit: BoxFit.contain)
                                  : Image.asset(evo.imageUrl, fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  evo.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Wrap(
                                  spacing: 8.w,
                                  children: evo.typeOfPokemon.map((t) {
                                    final type = mapPokemonType(t);
                                    return Container(
                                      width: 48.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: type.color,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Center(
                                        child: type.imagePath != null
                                            ? SvgPicture.asset(
                                                type.imagePath!,
                                                width: 12.sp,
                                                height: 12.sp,
                                                colorFilter: const ColorFilter.mode(
                                                    Colors.white, BlendMode.srcIn),
                                              )
                                            : Icon(
                                                type.icon,
                                                color: Colors.white,
                                                size: 12.sp,
                                              ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
