import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
import 'package:register_app/widgets/helpers/shared_helpers.dart';
import 'package:register_app/widgets/inputs/custom_input_form_field.dart';
import 'package:register_app/widgets/messages/message_info.dart';

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

             _BodyFormModal(operacion: operacion, ),






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

final String operacion;

  const _BodyFormModal({ this.operacion = 'NEW'});

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



  String? selectedValueGender;
  int? contador = 0;
  DateTime?  _currentSelectedDate;
  String? username = '';
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
    contador = 0;
  }
                            
  _BodyFormModalState()
                            : _textEditingControllerDatePicker = TextEditingController(),
                              _textEditingControllerName = TextEditingController(),
                              _textEditingControllerSurname = TextEditingController();
                              
                               
                            

Future<DateTime?> getDateTimePicker() {

    return showDatePicker(
                          context: context,
                          initialDate: _currentSelectedDate ?? DateTime.now()  ,
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
     

String? updateFieldFromName( String field , String operacion){


if( operacion == 'EDIT' ){



void setSelect(){


    contador = contador!+1;
    print('$contador <----- contador ');
    
    if(selectedValueGender == null ){  // si no tenemos ningun valor en el select 
    print('$contador <----- contador ENTRAAAAAAA ');

                            if( usersProvider.userEdited.isNotEmpty){ // y el usuario no es nulo ponemos su valor

                                  GENDER gender = usersProvider.userEdited[0].gender;
                                  print('generoooooooooo>>>> ${gender.stringValue}');
                                  selectedValueGender = gender.stringValue;   
                            }               
    }

    
    

}

      String message = '';

      switch( field.toLowerCase() ){

              case 'name':
                  
                    setSelect();

                    if( _textEditingControllerName.text.isEmpty ){

                        message = usersProvider.userEdited.isNotEmpty ? usersProvider.userEdited[0].fullName : '  *Name';
                        _textEditingControllerName.text = message;

                    }else{
                         message = _textEditingControllerName.text;
                    }

              break;
              case 'surname':

                if( _textEditingControllerSurname.text.isEmpty ){

                        message = usersProvider.userEdited.isNotEmpty ? usersProvider.userEdited[0].surname : '  *Surname';
                        _textEditingControllerSurname.text = message;

                    }else{
                         message = _textEditingControllerSurname.text;
                    }

              break;
                  case 'birthday':

              if( _textEditingControllerDatePicker.text.isEmpty ){

                        message = usersProvider.userEdited.isNotEmpty ? Utils.dateFormatter( usersProvider.userEdited[0].birthDate ) : '  *Surname';
                        _textEditingControllerDatePicker.text = message;

                    }else{
                         message = _textEditingControllerDatePicker.text;
                    }
              break;
              //     case 'gender':

              //   //usersProvider.userEdited[0] == null  ? null : (selectedValueGender = usersProvider.userEdited[0].gender.stringValue.toString())

              //       if( usersProvider.userEdited.isNotEmpty ){

              //              GENDER gender = usersProvider.userEdited[0].gender;
                           
              //              print('generoooooooooo>>>> ${gender.stringValue}');
              //              //selectedValueGender = gender.stringValue ;
              //              message = gender.stringValue;
              //       }else{

              //         message ='';
              //       }
              // break;
      }

      return message;
     }
return null;
}






    
    return  Padding(


      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),

      child: Form(

        child: Column(
          children: [
      
            const SizedBox(height: 10),
      
            CustomTextFormField(
                                      hint: updateFieldFromName( 'name' ,widget.operacion ) ?? '  *Name',
                                      controller: _textEditingControllerName,
                                       
                                      ),
            
            const SizedBox(height: 10),
            
            CustomTextFormField(
                                       hint: updateFieldFromName( 'surname', widget.operacion ) ?? '  *Surname',
                                       controller: _textEditingControllerSurname,),
            
            const SizedBox(height: 10),
            
            CustomTextFormField(
                                      hint:updateFieldFromName( 'birthday',widget.operacion ) ?? '',
                                      icon: const Icon( Icons.event, size: 25),
                                      controller: _textEditingControllerDatePicker,
                                      onTap: ()async {
                                        _currentSelectedDate = await getDateTimePicker();
                                            try{
                                                    _textEditingControllerDatePicker.text = '  ${Utils.dateFormatter(_currentSelectedDate!)}';
                                            }catch(error ){
                                                  _textEditingControllerDatePicker.text = '';
                                            }
                                      },
                                      iconAction: () async {
      
      
                                        _currentSelectedDate = await getDateTimePicker();

                                                  try{
                                                          _textEditingControllerDatePicker.text = '  ${Utils.dateFormatter(_currentSelectedDate!)}';
                                                  }catch(error ){
                                                        _textEditingControllerDatePicker.text = '';
                                                  }
                                      
      
                                        }, 
                                      ),//,
  
           

                                 // 
                                  const SizedBox(height: 10,),

                                  
                                                         
                                Center(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: const Row(
                                              children: [
                                                // Icon(
                                                //   Icons.list,
                                                //   size: 16,
                                                //   color: Colors.black,
                                                // ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    ' *Gender',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: generos
                                                .map((String item) => DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ))
                                                .toList(),
                                            value:   selectedValueGender ,
                                            onChanged: (String? value) {

                                              selectedValueGender = value;
                                                print('ejecutando $value');
                                                
                                              
                                              setState(() {
                                                
                                              });
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              height: 51,
                                              width: 326,
                                              padding: const EdgeInsets.only(left: 14, right: 14),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(9),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: const Color.fromARGB(255, 236, 235, 235),
                                              ),
                                              elevation: 2,
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.expand_more,
                                                  size: 30,
                                              ),
                                              iconSize: 14,
                                              iconEnabledColor: Colors.black,
                                              iconDisabledColor: Colors.grey,
                                            ),
                                            dropdownStyleData: DropdownStyleData(
                                              maxHeight: 200,
                                              width: 320,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              offset: const Offset(0, 0),
                                              scrollbarTheme: ScrollbarThemeData(
                                                radius: const Radius.circular(10),
                                                thickness: MaterialStateProperty.all<double>(6),
                                                thumbVisibility: MaterialStateProperty.all<bool>(true),
                                              ),
                                            ),
                                            menuItemStyleData: const MenuItemStyleData(
                                              height: 30,
                                              padding: EdgeInsets.only(left: 14, right: 14),
                                            ),
                                          ),
                                        ),
                                      ),
    const SizedBox(height: 20),




Wrap(
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
            
                switch ( widget.operacion ) {

                  
                    case 'NEW':
                                  // TODO: CREAR NUEVO USUARIO!

                                          try{

                                            final User newUser = User(
                                                fullName: _textEditingControllerName.text,
                                                surname: _textEditingControllerSurname.text,
                                                birthDate: _currentSelectedDate! == DateTime.now() ? throw Exception('División por cero no permitida') : _currentSelectedDate!  ,
                                                gender: selectedValueGender == 'Male'? GENDER.male : GENDER.female 
                                                );
  
                                                usersProvider.addUser(newUser);

                                                         

                                            }catch( error ){

                                                        print(error);
                                            }

                                                          //TODO: MOSTRAR SNACKBAR

                                                           Navigator.pop(context);

                                                         

                      break;

                      case 'EDIT':
                                  // TODO: EDITAR NUEVO USUARIO!

                                 final User userEdited = User(
                                                              fullName: _textEditingControllerName.text,
                                                              surname: _textEditingControllerSurname.text,
                                                              birthDate: _currentSelectedDate ?? usersProvider.userEdited[0].birthDate ,
                                                              gender: selectedValueGender == 'Male'? GENDER.male : GENDER.female 
                                                              );

                                  usersProvider.updateUser(userEdited);

                                  Navigator.pop(context);
                      break;
                
                }

    
          },
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(105, 28)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(
                      255, 14, 16, 143)) // Ancho y alto específicos
              ),
          child: widget.operacion == 'NEW'
                                  ? const Text('Save')
                                  : const Text('Update'),
        ),
      ],
   
)





          ],
        ),
     
      ),



    );
  }
}


///
/// parte final del formulario que hace refencia a la parte de los botones
///

// class _ButtonerModal extends StatelessWidget {

//   final String operacion;
//   // final String genderValue;
//   // final DateTime dateTimeValue;
//   // final String name;
//   // final String surname;

//   const _ButtonerModal({
//                         required this.operacion,
//                         // required this.genderValue,
//                         // required this.dateTimeValue,
//                         // required this.name,
//                         // required this.surname,
//                       });

//   @override
//   Widget build(BuildContext context) {
    // return Wrap(
    //   alignment: WrapAlignment.center, // Alineación centrada
    //   children: [
    //     ElevatedButton(
    //       onPressed: () {
            
    //         Navigator.pop(context);
    //       },
    //       style: ButtonStyle(
    //           minimumSize:
    //               MaterialStateProperty.all(const Size(105, 28)),
    //           backgroundColor: MaterialStateProperty.all(
    //               const Color.fromARGB(255, 223, 223,
    //                   225)) // Ancho y alto específicos
    //           ),
    //       child: const Text('Cancelar'),
    //     ),
    //     const SizedBox(
    //       width: 10,
    //     ),
    //     ElevatedButton(
    //       onPressed: () {
            
    //             switch ( operacion ) {

                  
    //                 case 'NEW':
    //                               // TODO: CREAR NUEVO USUARIO!

    //                   break;

    //                   case 'EDIT':
    //                               // TODO: EDITAR NUEVO USUARIO!
    //                   break;
                
    //             }

    //         // TODO: OPERACIONES! borrado / edición 
    //       },
    //       style: ButtonStyle(
    //           minimumSize:
    //               MaterialStateProperty.all(const Size(105, 28)),
    //           backgroundColor: MaterialStateProperty.all(
    //               const Color.fromARGB(
    //                   255, 14, 16, 143)) // Ancho y alto específicos
    //           ),
    //       child: operacion == 'NEW'
    //                               ? const Text('Save')
    //                               : const Text('Update'),
    //     ),
    //   ],
    // );
//   }
// }






/**
 * 
 *  DROPDOWN echo por mi pero me he optado por usar la librería de terceros dropdown_button2
 * 
 *   
                                  //   DropdownMenu<String>(
                                      
                                  //     width: 320,
                                  //     trailingIcon: const Icon(Icons.expand_more, size: 30),
                                  //     inputDecorationTheme: InputDecorationTheme(
                                       
                                  //       border: OutlineInputBorder(
                                  //                 borderRadius: BorderRadius.circular(11),
                                  //     ),
                                  //     isDense: true,

                                  //     ),
                                  //     initialSelection: list.first,
                                  //     onSelected: (String? value) {
                                  //       // This is called when the user selects an item.
                                  //       setState(() {
                                  //         dropdownValue = value!;
                                  //       });
                                  //     },
                                  //     dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                                  //       return DropdownMenuEntry<String>(value: value, label: value);
                                  //     }).toList(),
                                  //  ),
 * 
 * 
 * 
 */