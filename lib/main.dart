import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_app/config/router/app_router.dart';
import 'package:register_app/config/theme/app_theme.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
Future main() async{


  runApp(const MyApp());
  
  
}


///
///  Configuramos las RUTAS con la dependencia de go_router
///  y añadimos nuestro PROVIDER en el root de la aplicación
///  y con el operador de cascada '..' apuntamos al objeto raiz y llamamos al metodo para cargar el estado
///  pero realmente retorna un objeto de tipo UserProvider(), por defecto los providers actuan de manera Perezosa
///  por lo que en primer momento de general la aplicación llamamos el metodo del provider
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MultiProvider(

      providers: [
         
          
          ChangeNotifierProvider(
                                  lazy: false,
                                  create: (context)=> UserProvider()..loadUsers()
                                 ),
     
          
      ],

      child: MaterialApp.router(
    
        routerConfig:  appRouter,
    
        title: 'Registro',      
    
        debugShowCheckedModeBanner: false,
    
        theme: AppTheme(selectedColor: 1).getTheme(),
    
      ),
    );

  }
}

