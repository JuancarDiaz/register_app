import 'package:flutter/material.dart';
import 'package:register_app/widgets/helpers/shared_helpers.dart';
import 'package:register_app/widgets/inputs/custom_input_form_field.dart';

///
/// Clase estatica de Helpers para realizar operaciones 
/// [ fireModal(BuildContext context, String operacion] metodo que recibe dos parametros, el contexto y el tipo
/// de operación para editar o crear un nuevo usuario
///

class HelperModal {



  static Future<String?> fireModal(BuildContext context, String operacion) {
    
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: _HeaderInfoModal( operacion : operacion ),
      ),
    );
  }
}


///
/// División del modal en pequeñas partes mas accesibles esta se refiere a la parte de la información
/// y cabecera del Modal
///

class _HeaderInfoModal extends StatelessWidget {
  
  final String operacion;
  
  const _HeaderInfoModal({
                           required this.operacion
                          });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 235, 236, 234),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Center(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 23, 10, 0),
                      child: operacion == 'NEW'
                          ? const Text(
                              'Create New Patient',
                              style: TextStyle(fontSize: 20),
                            )
                          : const Text(
                              'Edit Patient',
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0, // Ajusta la posición vertical
                  right: 0, // Ajusta la posición horizontal
                  child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {

                          Navigator.pop(context);

                    },
                  ),
                ),
              ],
            ),

            const _BodyFormModal(),

            _ButtonerModal( operacion: operacion,)

          ],
        ),
      ),
    );
  }
}


///
/// Cuerpo principal del modal en el que se redimensiona un Formulario
///


class _BodyFormModal extends StatefulWidget {

  const _BodyFormModal();

  @override
  State<_BodyFormModal> createState() => _BodyFormModalState();
}

///
///
/// clase encargada de renderizar todo el contenido del formulario,
/// con un metodo interno para invocar el datepicker [callDatePicker]
/// Variables:
///            [_currentSelectedDate] hacen referencia a los campos de los formularios, para su vinculación
///            [_textEditingControllerName]
///            [_textEditingControllerSurname]
///            [_textEditingControllerDateGender]
///

class _BodyFormModalState extends State<_BodyFormModal> {

      // Variables
      var  _currentSelectedDate;
      final TextEditingController _textEditingControllerDatePicker;
      final TextEditingController _textEditingControllerName;
      final TextEditingController _textEditingControllerSurname;
      final TextEditingController _textEditingControllerDateGender;
      String dropdownValue = list.first;

      // Constructor
      _BodyFormModalState()
                            : _textEditingControllerDatePicker = TextEditingController(),
                              _textEditingControllerName = TextEditingController(),
                              _textEditingControllerSurname = TextEditingController(),
                              _textEditingControllerDateGender = TextEditingController();

Future<DateTime?> getDateTimePicker() {

    return showDatePicker(
                          context: context,
                          initialDate: _currentSelectedDate ?? DateTime.now()  ,
                          firstDate: DateTime(2017),
                          lastDate: DateTime(2025),
                          builder: (context, child) {

                                return Theme(data: ThemeData.dark(), child: child!);
                          },
                          );
}


  @override
  Widget build(BuildContext context) {
    return  Padding(


      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),

      child: Form(

        child: Column(
          children: [
      
            const SizedBox(height: 10),
      
            CustomTextFormField(
                                      hint: '  *Name',
                                      controller: _textEditingControllerName,

                                      ),
            
            const SizedBox(height: 10),
            
            CustomTextFormField(
                                       hint: '  *Surname',
                                       controller: _textEditingControllerSurname,),
            
            const SizedBox(height: 10),
            
            CustomTextFormField(
                                      icon: const Icon( Icons.event, size: 25),
                                      controller: _textEditingControllerDatePicker,
                                      onTap: ()async {
                                        _currentSelectedDate = await getDateTimePicker();
                                            try{
                                                    _textEditingControllerDatePicker.text = '  ${Utils.dateFormatter(_currentSelectedDate)}';
                                            }catch(error ){
                                                  _textEditingControllerDatePicker.text = '';
                                            }
                                      },
                                      iconAction: () async {
      
      
                                        _currentSelectedDate = await getDateTimePicker();

                                                  try{
                                                          _textEditingControllerDatePicker.text = '  ${Utils.dateFormatter(_currentSelectedDate)}';
                                                  }catch(error ){
                                                        _textEditingControllerDatePicker.text = '';
                                                  }
                                      
      
                                        }, 
                                      ),//,
            const SizedBox(height: 10),
            CustomTextFormField(
                                  icon: const Icon(Icons.expand_more, size: 30),
                                  controller: _textEditingControllerDateGender,
                                  iconAction: (){
      
      //TODO: MOSTRAR UN SELECT
      
                                  }

                                  ),// 
                                  const SizedBox(height: 10,),

                                  
                                    
                                    DropdownMenu<String>(
                                      
                                      width: 320,
                                      trailingIcon: const Icon(Icons.expand_more, size: 30),
                                      inputDecorationTheme: InputDecorationTheme(
                                       
                                        border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(11),
                                      ),
                                      isDense: true,
                                      
                                      ),
                                      initialSelection: list.first,
                                      onSelected: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                                        return DropdownMenuEntry<String>(value: value, label: value);
                                      }).toList(),
                                   ),
                                  



          ],
        ),
     
      ),



    );
  }
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
///
/// parte final del formulario que hace refencia a la parte de los botones
///

class _ButtonerModal extends StatelessWidget {

  final String operacion;

  const _ButtonerModal({
                        required this.operacion
                      });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center, // Alineación centrada
      children: [
        ElevatedButton(
          onPressed: () {
            
            Navigator.pop(context);
          },
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(105, 28)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 223, 223,
                      225)) // Ancho y alto específicos
              ),
          child: const Text('Cancelar'),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {
            
                switch ( operacion ) {

                  
                    case 'NEW':
                                  // TODO: CREAR NUEVO USUARIO!

                      break;

                      case 'EDIT':
                                  // TODO: EDITAR NUEVO USUARIO!
                      break;
                
                }

            // TODO: OPERACIONES! borrado / edición 
          },
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(105, 28)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(
                      255, 14, 16, 143)) // Ancho y alto específicos
              ),
          child: operacion == 'NEW'
                                  ? const Text('Save')
                                  : const Text('Update'),
        ),
      ],
    );
  }
}



