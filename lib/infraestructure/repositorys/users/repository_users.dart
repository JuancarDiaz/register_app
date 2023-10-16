

import 'package:register_app/infraestructure/models/usuario.dart';

List<User> usersListRepository =  [


        User(
            fullName: 'Juan Carlos Díaz',
            birthDate: DateTime.now(),
            gender: GENDER.male
        ), User(
            fullName: 'Elena Pérez',
            birthDate: DateTime.now(),
            gender: GENDER.female
        ), User(
            fullName: 'Eladio Potter',
            birthDate: DateTime.now(),
            gender: GENDER.male
        ),
];