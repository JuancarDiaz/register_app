import 'package:flutter/material.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/infraestructure/repositorys/users/repository_users.dart';


///
///
/// para gestionar el estado de los datos y que sean consistentes tengo varios objetos
/// [listUsersProvider] -> es el encargado de obtener los valores del Repositorio
/// simulando la procedencia de bases de datos o un servicio, dicho objeto no es tocado
/// pero es necesario para copiar su información en [copyListUsersProvider] y [sowhowlistUsersProvider]
/// respectivamente.
/// Ambos son necesarios [sowhowlistUsersProvider] -> destinado a mostrar los datos finalmente
/// y [copyListUsersProvider] es modificado cuando se produce borrado
///
///

class UserProvider extends ChangeNotifier {


List<User> listUsersProvider = [];
List<User> copyListUsersProvider = [];
List<User> sowhowlistUsersProvider = [];
bool initialLoadding = true;



///
/// Carga inicial de valores por defecto de una fuente de datos
///

Future<void> loadUsers() async {

          await Future.delayed( const Duration( milliseconds: 150) );

          List<User> users = usersListRepository.toSet().toList();
          
          listUsersProvider.addAll( users );

          copyListUsersProvider          = [...listUsersProvider];    // copiamos la listas a otros objetos en memoria
          sowhowlistUsersProvider        = [...listUsersProvider];

          initialLoadding = false;

          notifyListeners();
}




///
/// Busque da de usuario por nombre con los parámetros [userName] para buscar por el nombre del usuario
/// y el parámetro [tiempoEspera] para gestionar la espera asincronica en función de la operación requerida
///

Future<void> findUsers( String userName , {int tiempoEspera = 100} ) async {

      await Future.delayed(  Duration( milliseconds: tiempoEspera) );

      sowhowlistUsersProvider = [...copyListUsersProvider];

      sowhowlistUsersProvider = sowhowlistUsersProvider.where((user) => user.fullName.contains(userName) ).toList();

       notifyListeners();
}


///
///
///  Metodo que borra usuarios por el id del usuario 
///

Future<void> deleteUser( String idUser ) async{

         int indexUser = copyListUsersProvider.indexWhere((user) => user.id == idUser);

         copyListUsersProvider.removeAt(indexUser);

         sowhowlistUsersProvider = [...copyListUsersProvider];

         notifyListeners();
}



///
///
///
///
///

Future<void> addUser(User user) async{

  await Future.delayed( const Duration(milliseconds: 200));


  copyListUsersProvider.add(user);
  sowhowlistUsersProvider.add(user);
  
   notifyListeners();
}

}