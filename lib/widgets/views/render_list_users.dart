


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

    final listUsers =  usersProvider.usersProvider;

    return Expanded(

      child: Center(

        child: listUsers.isNotEmpty ?  ListView.builder(

          scrollDirection: Axis.vertical,

          itemCount: listUsers.length,

          itemBuilder: (context, index) {

// TODO: -----> SI LA LISTA DE USUARIOS ESTÁ VACÍA MOSTRAR UN MENSAJE <-------
// TODO: -----> DEVERÍAMOS COMPROBAR CONSTANTEMENTE EN EL INPUT SI HAY USUARIOS TAMBIEN
// TODO: -----> POR QUE SI NO NO SE ACTUALIZA LA LISTA HASTA QUE NO DEJAMOS EL INPUT A ''
            final usuario = listUsers[ index ];

            return InfoUserEditDelete( user: usuario );    
            
          },
        ) : Text('No hay usuarios en la Lista'),
      )
      );
  }
}


