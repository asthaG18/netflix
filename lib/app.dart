import 'package:flutter/material.dart';
import 'package:netflix/res/strings.dart';
import 'package:netflix/utils/helpers/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
