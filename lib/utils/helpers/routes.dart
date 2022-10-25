import 'package:flutter/material.dart';
import 'package:netflix/modules/detail_screen/view/detail_screen.dart';
import 'package:netflix/modules/home_screen/view/home_screen.dart';
import 'package:netflix/modules/splash/view/splash.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String homeScreen = '/homeScreen';
  static const String detailScreen = '/detailScreen';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: ((context) => const Splash()),
      homeScreen: ((context) => const HomeScreen()),
      detailScreen: ((context) => const DetailScreen()),
    };
  }
}
