import 'package:flutter/material.dart';
import 'package:register_app/widgets/inputs/custom_input_form_field.dart';

/// FORMULARIO  de busqueda el cual se compone de un boton y un inputetext para el cual será el encargado
/// de filtrar los resultados de la lista de usuarios
/// Requiere un parametro [textEditingControllerInput] de tipo TextEditingController para poder obtener las 
/// propiedades del valor del input que es otro elemento encapsulado creado de manera personalizada [CustomTextFormField]
/// en la clase tenemos a la escucha de eventos del formulario tanto al cambio como al postear el formulario

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

    return Form(

      child: Row(

        children: [
          Expanded(
            child: CustomTextFormField(
              controller: _textEditingControllerInput,
              hint: 'Full name',
              onChanged: (value) {
                print('$value ...');
                // TODO: VALOR ACTUALIZADO AL CAMBIO DEL INPUT
              },
            ),
          ),

          const SizedBox(width: 15),
          
          IconButton(
            icon: const Icon(Icons.search),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900),
              iconColor: const MaterialStatePropertyAll(Colors.white),
            ),
            onPressed: () {
              String inputValue = _textEditingControllerInput.text;
              print('$inputValue <-----');
              // TODO: AQUI DEVEMOS LLAMAR AL PROVIDER QUE NOS FLITRE EL RESULTADO DE LA LISTA
            },
          )
        ],
      ),
    );
  }
}