

import 'package:register_app/infraestructure/models/usuario.dart';

/// DATOS de muestra siempre en vigor

List<User> usersListRepository =  [


        User(
            fullName: 'Juan Carlos ',
            surname: 'Diaz',
            birthDate: DateTime.now(),
            gender: GENDER.male
        ), User(
            fullName: 'Elena',
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