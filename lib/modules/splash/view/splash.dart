import 'package:flutter/material.dart';
import 'package:netflix/res/colors.dart';
import '../../../utils/helpers/routes.dart';
import '../../../res/images.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  _navigateToHomeScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateToHomeScreen(context);
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Image.asset(
          AppImages.netflix,
          width: MediaQuery.of(context).size.width - 100,
        ),
      ),
    );
  }
}
