import 'package:flutter/material.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/infraestructure/repositorys/users/repository_users.dart';


/// Este es un Servicio proveedor de datos usando el paquete [provider] el cual necesita extender de [ChangeNotifier]
///
/// para gestionar el estado de los datos y que sean consistentes tengo una lista
/// [listUsersProvider] -> es el encargado de obtener los valores del Repositorio
/// simulando la procedencia de bases de datos o un servicio externo, dicho objeto no es modificado
/// pero es necesario para copiar su información en [copyListUsersProvider] y [sowhowlistUsersProvider]
/// respectivamente.
///   [showowlistUsersProvider] -> destinado a mostrar los datos finalmente y
///   [copyListUsersProvider] es modificado cuando se produce borrado
///
///   algunas de las explicaciones más relevantes, [ List<User> userEdited ] dentro de el solo albergamos un User con el controlamos el movimiento
///   de los datos del usuario a EDITAR, y cuando sea necesario esa Lista se vacía para mantener cierto control en la aplicación
/// 
///   [loadMessage] booleano utilizado para mostrar mensajes de exito ya sea EDITANDO o CREANDO
///   

class UserProvider extends ChangeNotifier {


String idUserEdited = '';
List<User> listUsersProvider = [];
List<User> copyListUsersProvider = [];
List<User> showowlistUsersProvider = [];
List<User> userEdited = [];
bool initialLoadding = true;
bool loadMessage = false;
String operation = '';




///
/// Carga inicial de valores por defecto de una fuente de datos
/// datos cargados en el main con el operador de cascada
///

Future<void> loadUsers() async {

          await Future.delayed( const Duration( milliseconds: 150) );

          List<User> users = usersListRepository.toSet().toList();
          
          listUsersProvider.addAll( users );

          copyListUsersProvider    = [...listUsersProvider];    // copiamos las listas a otros objetos en memoria
          showowlistUsersProvider  = [...listUsersProvider];

          initialLoadding = false;

          notifyListeners();
}




///
/// Busqueda de usuario por nombre con los parámetros [userName] para buscar por el nombre del usuario
/// y el parámetro [tiempoEspera] para gestionar la espera asincronica en función de la operación requerida
///

Future<void> findUsers( String userName , {int tiempoEspera = 100} ) async {

      await Future.delayed(  Duration( milliseconds: tiempoEspera) );

      showowlistUsersProvider = [...copyListUsersProvider];

      showowlistUsersProvider = showowlistUsersProvider.where((user) => user.fullName.contains(userName) ).toList();

       notifyListeners();
}



///
///  Metodo que borra usuarios por el id del usuario dicho id es creado con el paquete [ uuid: ^3.0.5 ]
///

Future<void> deleteUser( String idUser ) async{

         int indexUser = copyListUsersProvider.indexWhere((user) => user.id == idUser);

         copyListUsersProvider.removeAt(indexUser);

         showowlistUsersProvider = [...copyListUsersProvider];

         notifyListeners();
}




///
/// Añadir a un usuario a la lista seleccionamos el tipo de [operacion] para mostrar ese texto dinamicamente ya sea en la creación o la edición
///


Future<void> addUser(User user) async{

  operation = 'added';

  userEdited.clear();

  await Future.delayed( const Duration(milliseconds: 200));

  copyListUsersProvider.add(user);
  showowlistUsersProvider.add(user);

        loadMessage = true;
        notifyListeners();

        Future.delayed( const Duration(milliseconds: 3000)).then((value) {

          loadMessage = false;
          notifyListeners();
         } );

   notifyListeners();
}




///
/// Busqueda del usuario por el [id] 
///


Future<User> findUser( String id ) async {

    userEdited.clear();

    await Future.delayed( const Duration(milliseconds: 200));

    User user = showowlistUsersProvider.firstWhere((user) => user.id == id);

    userEdited.add(user);

    notifyListeners();

    return user;
}


///
/// Método utilizado para dejar vacia la lista que contiene el usuario actual (el usuario que estamos editando)
/// es decir que mientras estemos en una operación de edición lo mantenemos en la lista de lo contrario lo sacamos de la lista
/// 
void borrarUser() => {
 
  userEdited.clear(),
  notifyListeners(),
  
};


///
/// Método para actualizar el usuario en la ventana emergente MODAL usa las variables [operacion] y [loadMessage] al igual que en el metodo
/// de addUser
///

Future<void> updateUser( User user ) async {

    operation = 'Updated';
    
    User userFound = showowlistUsersProvider.firstWhere( (user) => user.id == idUserEdited );

    user.id = userFound.id;

    int index = showowlistUsersProvider.indexOf( userFound );

        if( index != -1){

            showowlistUsersProvider[ index ] = user;
            copyListUsersProvider[ index ]   = user;
            
            loadMessage = true;
            notifyListeners();

            Future.delayed( const Duration(milliseconds: 3000)).then((value) {
              
              loadMessage = false;
              notifyListeners();
            } );

        }
        
      notifyListeners();
}

}