

import 'package:flutter/material.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/infraestructure/repositorys/users/repository_users.dart';

class UserProvider extends ChangeNotifier {

List<User> usersProvider = [];
bool initialLoadding = true;


Future<void> loadUsers() async {

          await Future.delayed( const Duration( seconds: 2) );

          List<User> users = usersListRepository;
          
          usersProvider.addAll( users );

          initialLoadding = false;

          notifyListeners();
}


void findUsers( String userName ) async {


      // await Future.delayed( const Duration( seconds: 2) );

       usersProvider = usersProvider.where((user) => user.fullName.contains(userName) ).toList();

       notifyListeners();

}



}