import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
import 'package:register_app/widgets/helpers/shared_helpers.dart';
import 'package:register_app/widgets/inputs/custom_input_form_field.dart';
import 'package:register_app/widgets/inputs/dropdown_custom.dart';

///
/// Clase estatica de Helpers para realizar operaciones relaccionadas con el MODAL
/// [ fireModal(BuildContext context, String operacion] metodo que recibe dos parametros, el contexto y el tipo
/// de operación para editar o crear un nuevo usuario
///

class HelperModal {
  ///
  /// Metodo con el creamos un nuevo modal
  ///

  static Future<String?> fireModal(BuildContext context, String operacion) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: _HeaderInfoModal(operacion: operacion),
      ),
    );
  }
}

///
/// Construcción de la cabecera del modal el cual la información del titulo cambiará dinámicamente
/// requiere el tipo de operación [operacion] con un botón '(x)' para cerrar desde ahí el dialogo
///

class _HeaderInfoModal extends StatelessWidget {
  final String operacion;

  const _HeaderInfoModal({required this.operacion});

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
                              style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                            )
                          : const Text(
                              'Edit Patient',
                              style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0, // Ajusta la posición vertical
                  right: 0, // Ajusta la posición horizontal
                  child: IconButton(
                    style:const ButtonStyle(
                                        iconColor:MaterialStatePropertyAll(Color.fromARGB(255, 138, 136, 136)),
                                        iconSize: MaterialStatePropertyAll(27)
                                        ),
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            _BodyFormModal(
              operacion: operacion,
            ),
          ],
        ),
      ),
    );
  }
}

///
/// Cuerpo principal del modal en el que se redimensiona un Formulario
/// recibe como parámetro [operacion] para indicar dinamicamente un titulo nuevo
///

class _BodyFormModal extends StatefulWidget {
  final String operacion;

  const _BodyFormModal({required this.operacion});

  @override
  State<_BodyFormModal> createState() => _BodyFormModalState();
}

///
///
/// clase encargada de renderizar todo el contenido del formulario,
/// con un metodo interno para invocar el datepicker [callDatePicker]
/// Variables:
///            [_currentSelectedDate] hacen referencia a los campos de los formularios, para su vinculación:
///            [_textEditingControllerName]
///            [_textEditingControllerSurname]
///            [_textEditingControllerDateGender]
///

class _BodyFormModalState extends State<_BodyFormModal> {
  String? selectedValueGender;
  DateTime? _currentSelectedDate;
  late final TextEditingController _textEditingControllerName;
  late final TextEditingController _textEditingControllerSurname;
  late final TextEditingController _textEditingControllerDatePicker;
  late final UserProvider provider;
  final List<String> generos = [
    'Male',
    'Female',
  ];

  @override
  void initState() {
    super.initState();
  }

  _BodyFormModalState()
      : _textEditingControllerDatePicker = TextEditingController(),
        _textEditingControllerName = TextEditingController(),
        _textEditingControllerSurname = TextEditingController();

  ///
  /// Metodo interno para obtener la información del datepicker el cual obtiene la fecha actual[initialDate] asignada a la variable [_currentSelectedDate]
  /// con la que iremos actualizando los valores del input
  /// y se configuran unos valore máximos y mínimos a seleccionar [firstDate] [lastDate]
  ///

  Future<DateTime?> getDateTimePicker() {
    return showDatePicker(
      context: context,
      initialDate: _currentSelectedDate ?? DateTime.now(),
      firstDate: DateTime(2017),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(data: ThemeData.light(), child: child!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider usersProvider = context.watch<UserProvider>();

    /// Metodo interno
    /// [setSelect]
    /// Metodo el cual solo va ha ser disparado una única vez el cual cargará el valor por defecto del DropDown
    /// solo en el caso de estár editando solo se dispara si el valor del[selectedValueGender] o valor del dropDown está vacío
    /// y estamos editando eso quiere decir que quermos cargar el valor del usuario a editar
    /// [ usersProvider.userEdited 0 ] --> recordar que este usuario solo está cuando editamos en el provider y cuando creamos se borra
    ///                                    por eso devemos comprobar si es nullo
    ///                                    El dropDown solo admite valores definidos anteriormente en la lista ('Male' 'Female')
    ///
    void setSelectDropDown() {
      if (selectedValueGender == null) {
        // si no tenemos ningun valor en el dropDown

        if (usersProvider.userEdited.isNotEmpty) {
          // y el usuario no es nulo ponemos su valor

          GENDER gender = usersProvider.userEdited[0].gender;

          selectedValueGender = gender.stringValue;
        }
      }
    }

    /// Metodo interno
    /// [ updateFieldFromName ]
    /// Método interno el cual recibe como parámetros [field] y [operacion] , como este body FORMULARIO va a estar dentro de un MODAL
    /// el cual se va utilizar tanto para EDITAR como para CREAR, solo utilizamos este metodo para [EDITAR] por eso tenemos una bandera
    /// por que estos metodos son llamados a la hora de crear cada input del formulario y en ese preciso momento realiza tareas de asignación
    /// de variables.
    /// metodo se ejecutrá por cada inputCustom del formulario y establecerá o no las propiedades:  LABEL o VALUE
    ///
    ///             su uso será igual en todos los casos con el mismo fin
    ///                                                                                        | realiza las operaciones en funcion del field
    ///         CustomTextFormField(                                                           | si el textEditing del input no tiene valor y estamos editando
    ///           hint: updateFieldFromName( 'name' ,widget.operacion ) ?? '  *Name', <======= | se le asigna el valor de user seleccionado de lo contrario le asignamos otro valor por defecto
    ///           controller: _textEditingControllerName,                                      | y retornamos ese valor [message] que es el que recive el hint
    ///                                                                                        |
    ///           ),
    /// [field] -> tipo de campo del formulario sobre el que va a realizar las operaciones de configuración
    ///
    String? updateFieldFromName(String field) {
      if (widget.operacion == 'EDIT') {
        String message = '';

        switch (field.toLowerCase()) {
          case 'name':
            setSelectDropDown(); // ESTABLECEMOS LOS VALORES DEL DROPDOWN CUANDO EDITAMOS UN USUARIO ( podríamos haberlo utilizado en cualquier puto del switch)

            if (_textEditingControllerName.text.isEmpty) {
              message = usersProvider.userEdited.isNotEmpty
                      ? usersProvider.userEdited[0].fullName
                      : '*Name';
              _textEditingControllerName.text = message;
            } else {
              message = _textEditingControllerName.text;
            }

            break;
          case 'surname':
            if (_textEditingControllerSurname.text.isEmpty) {
              message = usersProvider.userEdited.isNotEmpty
                      ? usersProvider.userEdited[0].surname
                      : '*Surname';
              _textEditingControllerSurname.text = message;
            } else {
              message = _textEditingControllerSurname.text;
            }

            break;
          case 'birthday':
            if (_textEditingControllerDatePicker.text.isEmpty) {
              message = usersProvider.userEdited.isNotEmpty
                      ? Utils.dateFormatter(usersProvider.userEdited[0].birthDate)
                      : '*birthday';
              _textEditingControllerDatePicker.text = message;
            } else {
              message = _textEditingControllerDatePicker.text;
            }
            break;
        }

        return message;
      }
      return null;
    }

    ///
    /// Widget PRINCIPAL a retornar
    ///
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 10),

            CustomTextFormField(
              hint: updateFieldFromName('name') ?? '*Name',
              controller: _textEditingControllerName,
            ),

            const SizedBox(height: 10),

            CustomTextFormField(
              hint: updateFieldFromName('surname') ?? '*Surname',
              controller: _textEditingControllerSurname,
            ),
            const SizedBox(height: 10),

            CustomTextFormField(
              hint: updateFieldFromName('birthday') ?? '*birthday',
              icon: const Icon(Icons.event, size: 27,color: Color.fromARGB(255, 69, 107, 20),),
              controller: _textEditingControllerDatePicker,
              onTap: () async {
                                                                    /// realizamos la misma operacion para [onTap] y [iconAction]
                _currentSelectedDate = await getDateTimePicker();

                                                                      /// que es un callback personalizado del input
                                                                      /// obtenemos la fecha y nos aseguramos que no esté vacía
                try {
                  _textEditingControllerDatePicker.text =
                      '  ${Utils.dateFormatter(_currentSelectedDate!)}';
                } catch (error) {
                  _textEditingControllerDatePicker.text = '';
                }
              },
              iconAction: () async {
                _currentSelectedDate = await getDateTimePicker();

                try {
                  _textEditingControllerDatePicker.text =
                      '  ${Utils.dateFormatter(_currentSelectedDate!)}';
                } catch (error) {
                  _textEditingControllerDatePicker.text = '';
                }
              },
            ), //,

            const SizedBox( height: 10,),

            DropDownCusttom(
              generos: generos,
              selectedValueGender: selectedValueGender,
              callback: (value) {
                selectedValueGender = value;
              },
            ),

            const SizedBox( height: 23,),

            Wrap(
              alignment: WrapAlignment.center,

                                                                      /// Zona de la botonera [ Cancel ] / [ Update / Save ]
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      minimumSize:
                         MaterialStateProperty.all(const Size(128, 33)),
                      backgroundColor: MaterialStateProperty.all(
                         const Color.fromARGB(204, 241, 241, 244)),
                      ),
                  child: const Text('Cancelar',style:  TextStyle(color: Color.fromARGB(146, 93, 92, 92),fontSize: 16,fontWeight: FontWeight.w600),),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                                                                      /// Operaciones mediante botones para crear o modificar
                    switch (widget.operacion) {
                      case 'NEW':
                        try {
                          final User newUser = User(
                              fullName: _textEditingControllerName.text,
                              surname: _textEditingControllerSurname.text,
                              birthDate: _currentSelectedDate! == DateTime.now()
                                  ? throw Exception('fecha no seleccionada')
                                  : _currentSelectedDate!,
                              gender: selectedValueGender == 'Male'
                                  ? GENDER.male
                                  : GENDER.female);

                          usersProvider.addUser(newUser);
                        } catch (error) {
                          ///print(error);
                        }

                        break;

                      case 'EDIT':
                        final User userEdited = User(
                            fullName: _textEditingControllerName.text,
                            surname: _textEditingControllerSurname.text,
                            birthDate: _currentSelectedDate ??
                                usersProvider.userEdited[0].birthDate,
                            gender: selectedValueGender == 'Male'
                                ? GENDER.male
                                : GENDER.female);

                        usersProvider.updateUser(userEdited);

                        break;
                    }
                    Navigator.pop(context);                                   /// DESPUÉS DE CUALQUIER OPERACIÓN VOLVEMOS A LA PANTALLA ANTERIOR
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(128, 33)),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(179, 7, 7, 147)) 
                      ),
                  child: widget.operacion == 'NEW'
                      ? const Text('Save',style: TextStyle(color: Colors.white,fontSize: 16),)
                      : const Text('Update',style: TextStyle(color: Colors.white,fontSize: 16),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
