
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// static const String  [name] = 'start_register_router' propiedad estatica para acceder a el identificador 
/// de esta clase en el Router   
/// 
/// 
class StartPageRegister extends StatelessWidget {
  const StartPageRegister({super.key});


   static const String  name = 'start_register_router';

  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;

    return  Scaffold( 

                body:  Container(

                decoration: const BoxDecoration(

                        image: DecorationImage( 
                                                image: AssetImage('assets/images/robot.jpg'),
                                                fit: BoxFit.cover
                        ),      
                  ),
                child:  Center(  

                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            
                              const Text('Welcome', style: TextStyle(fontSize: 35, color: Colors.white)),
                            

                              const SizedBox(height: 20), // Espacio entre el texto y el botón

                              _CustomButtom( 
                                            texto: 'Start',
                                            colorBackGround: Colors.white,
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
 final Color  colorBackGround;
 final String texto;
  
  const _CustomButtom(
                      { super.key,
                        this.onPressedCallback,
                        this.colorTextoSelected,
                        this.colorBackGround = Colors.red,
                        required this.texto
                        });


  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;

    return ClipRRect(

        borderRadius: BorderRadius.circular(20),

      child: Material(
    
        color:colorBackGround, //colorBackGround ?? colors.primary,
    
        child: InkWell( // opciones de clikado eventos
    
          onTap: onPressedCallback,

          child: Padding(
            
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        
                        child:  Text( texto ,style:  TextStyle(color:colorTextoSelected,),)
            
                        ),
        ),
      ),
    );
  }
}