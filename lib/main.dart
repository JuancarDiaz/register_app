import 'package:flutter/material.dart';
import 'package:register_app/config/router/app_router.dart';
import 'package:register_app/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      routerConfig:  appRouter,

      title: 'Registro',

      debugShowCheckedModeBanner: false,

      theme: AppTheme(selectedColor: 1).getTheme(),

    );

  }
}

