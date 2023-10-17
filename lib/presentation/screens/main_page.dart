import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
import 'package:register_app/widgets/helpers/modal_helper.dart';
import 'package:register_app/widgets/forms/form_busqueda.dart';
import 'package:register_app/widgets/views/render_list_users.dart';


///
///
/// [_HeaderFilterAndBodyCustom] clase personalizada que centraliza todos los elementos de la pantalla principal
/// para facilitar su legibilidad aplicamos un SafeArea para evitar ocupar zonas del movil que ocupan otros usos
///
///

class MainPageRegister extends StatelessWidget {
  const MainPageRegister({super.key});

  static const String name = 'main_register_router';

    

  @override
  Widget build(BuildContext context) {
    
      final currentDate = DateTime.now();
      final formattedDate = DateFormat('MMMM d\'th\', y').format(currentDate);

    return  Scaffold(

            body: SafeArea(

                    child: _HeaderFilterAndBodyCustom(formattedDate: formattedDate),
              ),

            floatingActionButton: const _NewUserModal(),

    ) ;
  }
}



/// ENCAPSULAMOS el boton modal
/// llamamos a la clase estatica de helpers para acceder al modal[HelperModal.fireModal]
/// dicho metodo utiliza el segundo argumento [operacion] para mandar al modal la opcion de CREAR O EDITAR
/// y mostrar elementos en concreto
/// boton usado para lanzar el MODAL y crear usuarios nuevos

class _NewUserModal extends StatelessWidget {
  const _NewUserModal();

  @override
  Widget build(BuildContext context) {

      final UserProvider userProvider = context.watch<UserProvider>();

        return IconButton(
                      
          onPressed: () {

                                HelperModal.fireModal(context,'NEW');
                                 userProvider.borrarUser();
          },
                               

                                icon: const Icon(Icons.add),
                                iconSize: 41,
                                color: Colors.white ,
                                style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade900,
                                ),
                                
                      );
  }
}







/// 
/// Creación de un encabezado personalizado donde se configura la fecha en su formato correcto y 
/// para importar formateo de las fechas usamos la dependencia de [intl: ^0.17.0]  
/// 
class _HeaderFilterAndBodyCustom extends StatelessWidget {
      _HeaderFilterAndBodyCustom({required this.formattedDate,});

  final String formattedDate;
  final String textoInput = '';

  final TextEditingController _textEditingControllerInput = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Padding(       // Padding general a todo el bloque
            
      padding:const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15), 
            
      child: Column( // Disposición interior en columnas de todos los elementos hijos
            
        crossAxisAlignment: CrossAxisAlignment.center, // centrado del contenido
        
                children: [
 
                  _Header(formattedDate: formattedDate),

                  _Filtro(textEditingControllerInput: _textEditingControllerInput),

                  const RenderizarListaUsuarios(),

                ],
      ),
            );
  }
}




///
///
///  Filtro de usuarios centralizado en que usa una instancia de [FormBusqueda]
///
///

class _Filtro extends StatelessWidget {

const _Filtro({
                required TextEditingController textEditingControllerInput,
  }) 
    : _textEditingControllerInput = textEditingControllerInput;


  final TextEditingController _textEditingControllerInput;

  @override
  Widget build(BuildContext context) {
    return Column(

                children: [

                      const SizedBox(height: 25),
                
                      const Text('Patient List'),
                      
                      const SizedBox(height: 25),

                      FormBusqueda( textEditingControllerInput: _textEditingControllerInput ),

                      const SizedBox(height: 25),
                      
                ],
    );
  }
}











///
/// Cabecera de la pagina principal donde centramos un widget que contiene tanto un saludo como la fecha actual
/// recibe la fecha por parametro [formattedDate]
///

class _Header extends StatelessWidget {
  const _Header({
                  required this.formattedDate,
                });

  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Padding( // elementos centrados

      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),

      child: ClipRRect( // Creamos un elemento en cual va ha tener forma de cuadrado y
                        // dentro de el metemos todos sus elementos uno a cada lado

        child: Material( // Creamos un contenedor de Material para darle la apariencia
    
          color:Colors.grey.shade200,
          shadowColor: Colors.black,
    
          borderRadius: BorderRadius.circular(5), // al clipRect Ledamos un borde
          
                child: Padding(

                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),

                  child:  Row(
    
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      
                        children: [
                          
                          const Text('Hi, Welcome!'),
                          Text( formattedDate ),
         
                        ],
                  ),
                ),
        )
      ),
    );
  }
}














