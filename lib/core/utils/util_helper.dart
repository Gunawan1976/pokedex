

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../features/root/root_bloc.dart';
import '../../shared/enum.dart';
import '../constant.dart';
import 'hex_color.dart';

class UtilsHelper {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static late RootBloc rootBloc;


}

class PokemonType {
  final String name;
  final Color color;
  final IconData? icon;
  final String? imagePath;

  PokemonType({required this.name, required this.color, this.icon, this.imagePath});
}


