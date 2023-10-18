import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:register_app/widgets/inputs/custom_input_form_field.dart';

/// FORMULARIO  de busqueda el cual se compone de un boton y un inputText el cual será el encargado
/// de filtrar los resultados de la lista de usuarios
/// Requiere un parametro [textEditingControllerInput] de tipo TextEditingController para poder obtener las 
/// propiedades del valor del input que es otro elemento encapsulado creado de manera personalizada [CustomTextFormField]
/// en la clase tenemos a la escucha de eventos del formulario tanto al cambio como al postear el formulario
/// gestionamos la busqueda en el [onPressed] del botón (lupa)

class FormBusqueda extends StatelessWidget {

  // CONSTRUCTOR
  const FormBusqueda({
                      super.key,
                      required TextEditingController textEditingControllerInput,
  }) 
    : _textEditingControllerInput = textEditingControllerInput;

  final TextEditingController _textEditingControllerInput;


  @override
  Widget build(BuildContext context) {

  final usersProvider = context.watch<UserProvider>();
  
    return Form(

      child: Row(

        children: [
          Expanded(
            child: CustomTextFormField(
              controller: _textEditingControllerInput,
              hint: ' Full name',
              onChanged: (value) {

                usersProvider.findUsers( value, tiempoEspera: 400 );
  
              },
            ),
          ),

          const SizedBox(width: 15),
          
          IconButton(
            icon: const Icon(Icons.search),
            style: ButtonStyle(
              backgroundColor:const MaterialStatePropertyAll(Color.fromARGB(215, 19, 61, 154)),
              iconColor: const MaterialStatePropertyAll(Colors.white),
              minimumSize: MaterialStateProperty.all(const Size(55, 55)),
            ),
            onPressed: () {
              String inputValue = _textEditingControllerInput.text;
            
                 usersProvider.findUsers( inputValue, tiempoEspera: 150 );

            },
          )
        ],
      ),
    );
  }
}
