import 'package:flutter/material.dart';

final List<Color> colorList = [

  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.pink,
  Colors.white10,
];

class AppTheme {

  final selectedColor;

  AppTheme({this.selectedColor})
                                : assert( selectedColor >= 0, 'SELECTED COLOR MUST BE GREATHER THEN 0'),
                                  assert( selectedColor < colorList.length, 'SELECTED COLOR MUST BE SMALLER THAN SELECTEDCOLOR' );


  ThemeData getTheme() 
                      => ThemeData(
                        useMaterial3: true,
                        colorSchemeSeed:  colorList[ selectedColor ],
                        
                      );

}