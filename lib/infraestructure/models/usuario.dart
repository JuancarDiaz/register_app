import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

///
/// uso de la librería Equatable para comparar objetos necesita implementar el metodo [ props ] para establecer la igualdad
class User extends Equatable {

  late  String id;
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
        
          @override
          List<Object?> get props => [ fullName, birthDate, gender, surname ];
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

