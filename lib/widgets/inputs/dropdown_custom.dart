
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';






///
/// clase que se usa una libreria de terceros [dropdown_button2] para crear un elemento personalizado 
/// se le deve pasar una lista a renderizar en este caso [generos] mantenemos actualizado el valor constantemente
/// con la propiedad obligatoria [selectedValueGender] que será el valor que en cada momento tiene el dropDown
/// y cuando se obtiene el valor del dropDown cambiando su valor se ejecuta el callback que se le pasa por parámetro 
/// para poder recibir en el componente padre el valor de el mismo [callback]
///




class DropDownCusttom extends StatefulWidget {

  String? selectedValueGender;
  final List<String> generos;
  final  Function(String)  callback;
  final  Icon? icon;

   DropDownCusttom({
                        required this.generos,
                        required this.selectedValueGender,
                        required this.callback,
                        this.icon,
                        super.key,

                        });

  @override
  State<DropDownCusttom> createState() => _DropDownCusttomState();
}

class _DropDownCusttomState extends State<DropDownCusttom> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color.fromARGB(255, 103, 103, 103),
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: widget.generos
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
                                            value:   widget.selectedValueGender ,
                                            onChanged: (String? value) {

                                              widget.selectedValueGender = value;
                                              
                                              widget.callback(value ?? value.toString());
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
                                      );
  }
}


