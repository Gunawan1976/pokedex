import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vcc_remake_bloc/core/constant.dart';
import 'package:vcc_remake_bloc/core/utils/secure_storage_util.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("lib/assets/pokedex.svg",height: 100.h,width: 100.w,),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}