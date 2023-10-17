import 'package:flutter/material.dart';

/// 
/// [enabledBorder] se muestra cuando el widget de entrada no tiene el foco y está habilitado para la entrada
/// [focusedBorder] Este es el borde que se muestra cuando el widget de entrada tiene el foco
/// [errorBorder] Este es el borde que se muestra cuando se produce un error en la entrada del usuario
/// [focusedErrorBorder] Este es el borde que se muestra cuando el widget de entrada tiene el foco y también hay un error en la entrada
/// CONFIGURACIONES DEL FORMULARIO PERSONALIZADO, el cual admite las configuraciones que requiramos en cada situación
///            
/// 

class CustomTextFormField extends StatelessWidget {

  // Propiedades OPCIONALES de configuración del input.

  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final Function (String)?onChanged;
  final String Function(String?)? validator;
  final TextEditingController? controller;

  // Constructor con parametros opcionales
  const CustomTextFormField({
                              super.key,
                              this.label,
                              this.hint,
                              this.errorMessage,
                              this.obscureText = false,
                              this.onChanged,
                              this.validator,
                              this.controller
                            });

  @override
  Widget build(BuildContext context) {

    /// sacamos el color por defecto de nuestra configuración inicial del schema
    final colors = Theme.of(context).colorScheme;

    /// configuramos el color del borde para incluir en los inputs y su forma
    final border = OutlineInputBorder(
                                        borderRadius: BorderRadius.circular( 10 ),
                                        borderSide: BorderSide( color: colors.primary )
    );

    return TextFormField(

      onChanged: onChanged,
      validator: validator,
      
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(

                    
                    enabledBorder: border,
                    focusedBorder: border.copyWith( borderSide:const BorderSide( color:Colors.grey )),
                    errorBorder: border.copyWith( borderSide: BorderSide( color: Colors.red.shade800)),
                    focusedErrorBorder: border.copyWith( borderSide:  BorderSide( color: Colors.red.shade800)),
                    isDense: true,
                    label: label != null ? Text(label!) : null,
                    hintText: hint,
                    errorText:  errorMessage,
                    focusColor: colors.primary
                    
      ),

    );
  
  
  }
}
