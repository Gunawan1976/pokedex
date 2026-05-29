import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/features/index_page.dart';
import 'package:vcc_remake_bloc/features/splash_screen.dart';
import 'package:vcc_remake_bloc/features/home/presentation/home_page.dart';

import '../../features/favourite/presentation/favourite_page.dart';
import '../../features/detail/presentation/detail_pokemon_page.dart';
import '../../features/home/domain/entities/pokemon_entity.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return IndexPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favourite',
                name: 'favourite',
                builder: (context, state) => const FavouritePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) {
          final pokemon = state.extra as PokemonEntity;
          return DetailPokemonPage(pokemon: pokemon);
        },
      ),
    ],
  );
}
