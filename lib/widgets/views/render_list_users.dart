


import 'package:flutter/material.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/widgets/views/render_info_user.dart';

/// 
/// CLASE INTERNA encargada de renderizar la lista de usuarios  dentro del metodo ListView.builder
/// 

class RenderizarListaUsuarios extends StatelessWidget {
  const RenderizarListaUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Center(

        child: ListView.builder(

          scrollDirection: Axis.vertical,

          itemCount: 10,

          itemBuilder: (context, index) {

            final usuario =  User(fullName: 'Juan Carlos', birthDate: DateTime.now(), gender: GENDER.male );

            return InfoUserEditDelete( user: usuario );    
            
          },
        ),
      )
      );
  }
}


