


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
import 'package:register_app/widgets/views/render_info_user.dart';

/// 
/// CLASE INTERNA encargada de renderizar la lista de usuarios  dentro del metodo ListView.builder
/// [usersProvider] nos manetenemos a la escucha de los cambios que se ejecutan desde el controlador de provider
/// el cual se encarga de ejecutar el método notifyListeners(); de forma que renderiza el widget pero evalua 
/// los elementos existente y solo renderiza de nuevo de los elementos que han cambiado, el resto los obtiene de la caché
/// 

class RenderizarListaUsuarios extends StatelessWidget {
  const RenderizarListaUsuarios({super.key});

  @override
  Widget build(BuildContext context)  {

    final usersProvider = context.watch<UserProvider>();

    final listUsers =  usersProvider.showowlistUsersProvider;

    return Expanded(

      child: Center(
                                                        /// desplegamos las listas de los usuarios o mostramos mensaje si no hay registros
        child: listUsers.isNotEmpty 
                                    ? _RenderInfoUser( listUsers: listUsers ) 
                                    : const _MessageDataNotFound(),
      )
      );
  }
}



///
/// Clase destinada a renderizar la información del usuario recibe como parámetro [listUsers] la lista de 
/// usuarios a renderizar
///


class _RenderInfoUser extends StatelessWidget {
  const _RenderInfoUser({
                          required this.listUsers,
  });

  final List<User> listUsers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

           scrollDirection: Axis.vertical,

           itemCount: listUsers.length,

           itemBuilder: (context, index) {

               final usuario = listUsers[ index ];

               return InfoUserEditDelete( user: usuario );    
             
           },
         );
  }
}





///
///  Clase destinada a mostrar un mensaje que informe que no se han encontrado resultados
///


class _MessageDataNotFound extends StatelessWidget {
  const _MessageDataNotFound();

  @override
  Widget build(BuildContext context) {
    return  Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Material(
                    elevation: 6, // Establece la elevación para agregar sombra
                    color: const Color.fromARGB(255, 250, 248, 217),
                    borderRadius: BorderRadius.circular(5),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      child: Text(
                        'There are no registered patients.',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );

  }
}


