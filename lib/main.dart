import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/core/utils/app_router.dart';
import 'package:vcc_remake_bloc/core/utils/util_helper.dart';
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

import 'core/network/injection.dart';
import 'features/index/index_cubit.dart';
import 'features/root/root_bloc.dart';
import 'features/favourite/presentation/bloc/favourite_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final bloc = RootBloc();
            UtilsHelper.rootBloc = bloc;
            return bloc;
          },
        ),
        BlocProvider<IndexCubit>(create: (context) => IndexCubit()),
        BlocProvider<HomeBloc>(
          create: (context) => locator<HomeBloc>()..add(GetPokemonsEvent()),
        ),
        BlocProvider<FavouriteBloc>(
          create: (context) => locator<FavouriteBloc>()..add(LoadFavouritesEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// GLOBAL SNACKBAR
        BlocListener<RootBloc, RootState>(
          listenWhen: (prev, curr) => prev.snackbarId != curr.snackbarId,
          listener: (context, state) {
            UtilsHelper.scaffoldMessengerKey.currentState!
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: TextView(
                    text: state.snackbarMessage ?? "",
                    textColor: Colors.white,
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                ),
              );
          },
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          scaffoldMessengerKey: UtilsHelper.scaffoldMessengerKey,
          title: 'Template Bloc',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
