import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// static const String  [name] = 'start_register_router' propiedad estatica para acceder a el identificador
/// de esta clase en el Router
/// Pagina Inicial sobre la que a través del botón nos movemos al main
class StartPageRegister extends StatelessWidget {
  const StartPageRegister({super.key});

  static const String name = 'start_register_router';

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(   // 
              //image: AssetImage('assets/images/robot.jpg'), fit: BoxFit.cover), es posible que no estén disponibles los assets ... uso imagen web
              image: NetworkImage('https://media.urgente24.com/p/f2a1c41c3b8a64985ecf9af7770da015/adjuntos/319/imagenes/002/864/0002864755/las-preguntas-mas-frecuentes-sobre-la-realidad-virtual-y-la-inteligencia-artificialjpg.jpg'),fit: BoxFit.cover,scale: 1.0
              ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 50),

              const Text('Welcome',
                  style: TextStyle(fontSize: 46, color: Colors.white)),

              const SizedBox(height: 75), // Espacio entre el texto y el botón

              _CustomButtom(
                texto: 'Start',
                colorBackGround: const Color.fromARGB(255, 241, 240, 240),
                colorTextoSelected: Colors.black,
                onPressedCallback: () {
                  context.push('/mainList');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

///
///  [_CustomButtom] clase privada utilizada para construir botones el la aplicacion con algunos parametros personalizables
///  que se añaden opcionalmente como argumentos,
///  [ClipRRect] crea un cuadrado con la configuración siguiente, en este caso se le han redondeado los bordes
///  creamos un hijo, y dicho hijo va a ser envuelto con un widget [InkWell] para poder otorgarle de eventos
///  en este caso on tap que recibe un callback obligatorio por argumentos para poder ejercer el clicado

class _CustomButtom extends StatelessWidget {
  final VoidCallback? onPressedCallback;
  final Color? colorTextoSelected;
  final Color colorBackGround;
  final String texto;

  const _CustomButtom({
      this.onPressedCallback,
      this.colorTextoSelected,
      this.colorBackGround = const Color.fromARGB(255, 65, 59, 58),
      required this.texto});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: colorBackGround, //colorBackGround ?? colors.primary,

        child: InkWell(
          // opciones de clikado eventos

          onTap: onPressedCallback,

          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 130, vertical: 3),
              child: Text(
                texto,
                style: TextStyle(
                  color: colorTextoSelected,
                  fontSize:25 
                ),
              )),
        ),
      ),
    );
  }
}
