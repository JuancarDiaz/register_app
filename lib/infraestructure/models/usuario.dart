import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String fullName;
  final String surname;
  final DateTime birthDate;
  final GENDER gender;

  User({
        required this.fullName,
        required this.birthDate,
        required this.gender,
        required this.surname,
      })
         : id = Uuid().v4(); // Genera un nuevo UUID cada vez


         @override
         String toString() {

          return '''${super.toString()}
                     Id:[$id], name:[$fullName],
                     Surname:[$surname],
                     BirthDate:[$birthDate],
                     Genero:[${gender.toString()}]''';
        }
}



enum GENDER { male , female }


extension GenderExtension on GENDER {
  String get stringValue {
    switch (this) {
      case GENDER.male:
        return 'Male';
      case GENDER.female:
        return 'Female';
      default:
        return '';
    }
  }
}

