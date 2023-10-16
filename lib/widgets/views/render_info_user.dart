import 'package:flutter/material.dart';
import 'package:register_app/infraestructure/models/usuario.dart';


///
///
/// Clase destinada a prodesar cada fila obtenida de la lista de usuarios mostrando
/// su información personal aí como las opciones de edición 
/// [ birthDateFormated ] es la fecha del usuario formateada 
///


class InfoUserEditDelete extends StatelessWidget {
  
  final User user;

   const InfoUserEditDelete({
                            super.key,
                            required this.user,
                            });

  @override
  Widget build(BuildContext context) {
 
    final birthDate = user.birthDate.toString().split(' ')[0];//.replaceAll('-','/');
    final dia = birthDate.split('-')[2];
    final mes = birthDate.split('-')[1];
    final anio = birthDate.split('-')[0];

    final birthDateFormated = '$dia/$mes/$anio';

    return Padding( // elementos centrados

      padding: const EdgeInsets.fromLTRB(5, 2, 15, 5),

      child: ClipRRect( // Creamos un elemento en cual va ha tener forma de cuadrado y
                        // dentro de el metemos todos sus elementos uno a cada lado

        child: Material( // Creamos un contenedor de Material para darle la apariencia
    
          color:Colors.grey.shade200,
          shadowColor: Colors.black,
          
    
          borderRadius: BorderRadius.circular(18), // al clipRect Ledamos un borde
          
                child: Padding(

                 padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                  child:  Row(
    
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      
                        children: [
                         
                              _InfoUserLeft( user: user, birthDateFormated: birthDateFormated ),

                              _ButtonerRigth( user: user ),
         
                                ],
                  ),
                ),
        )
      ),
    );


  }
}




///
///
/// Zona derecha de la botonera: EDIT / DELETE / NEXT
///
///

class _ButtonerRigth extends StatelessWidget {
  
  final User user;

  const _ButtonerRigth({
                           required this.user
                      });

  @override
  Widget build(BuildContext context) {
    return Row(


          children: [
            IconButton(
                     icon: const Icon(Icons.edit),
                     style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(30),
                                iconColor: MaterialStateProperty.all(Colors.grey), // Color del icono
                                ),
                                onPressed: (){

                                        // TODO: EDIT
                                        print( 'EDIT '+ user.id.toString() );
                                            } 
                          ),
            
            IconButton(
                   icon: const Icon(Icons.delete),
                   style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(30),
                                iconColor: MaterialStateProperty.all(Colors.red.shade900), // Color del icono
                                ),
                                onPressed: (){

                                        // TODO: DELETE
                                        print( 'DELETE'+ user.id.toString() );
                                            },
            ),
            
            IconButton(
                    icon: const Icon(Icons.chevron_right),
                    style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(40),
                                iconColor: MaterialStateProperty.all(Colors.blue.shade900), // Color del icono
                                ),
                                onPressed: (){

                                        // TODO: NEXT
                                        print( 'NEXT'+ user.id.toString() );
                                            },
                  ),
                
          ],
        );
  }
}





///
///
/// Zona izquierda muestra la información de cada usuario
///
///


class _InfoUserLeft extends StatelessWidget {
  const _InfoUserLeft({
    super.key,
    required this.user,
    required this.birthDateFormated,
  });

  final User user;
  final String birthDateFormated;

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [


       Text( user.fullName, style: const TextStyle(fontSize: 13), ),
       Text( 'Birthdate $birthDateFormated', style: const TextStyle(fontSize: 12) ),
       Text( 'Genero: ' + user.gender.stringValue, style: const TextStyle(fontSize: 13) ),
     ],
                              );
  }
}