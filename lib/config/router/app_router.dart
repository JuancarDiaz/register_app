import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:register_app/presentation/screens.dart';

/// Instalación del paquete externo para gestionar las rutas usando esta variable de configuracion
///  paquete ---> flutter pub add go_router ... https://pub.dev/packages/go_router/install
/// dependencia añadida en el paquete pubspec.yaml

final appRouter = GoRouter(
  
  initialLocation: '/',

  routes: [

    GoRoute(
              path: '/',
              name: StartPageRegister.name,
              builder: (context, state) => const StartPageRegister(),
            ),
    GoRoute(
              path: '/mainList',
              name: MainPageRegister.name,
              builder: (context, state) => const MainPageRegister(),
            ),
  ]
  
  );