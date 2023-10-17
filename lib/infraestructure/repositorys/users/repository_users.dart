

import 'package:register_app/infraestructure/models/usuario.dart';

List<User> usersListRepository =  [


        User(
            fullName: 'Juan Carlos Díaz',
            surname: 'Diaz',
            birthDate: DateTime.now(),
            gender: GENDER.male
        ), User(
            fullName: 'Elena ',
            surname: 'Pérez',
            birthDate: DateTime.now(),
            gender: GENDER.female
        ), User(
            fullName: 'Eladio',
            surname: 'Potter',
            birthDate: DateTime.now(),
            gender: GENDER.male
        ),
];