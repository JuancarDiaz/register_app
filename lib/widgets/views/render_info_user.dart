import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_app/infraestructure/models/usuario.dart';
import 'package:register_app/presentation/providers/users_provider.dart';
import 'package:register_app/widgets/helpers/modal_helper.dart';
import 'package:register_app/widgets/helpers/shared_helpers.dart';


///
/// Clase destinada a prodesar cada fila obtenida de la lista de usuarios mostrando
/// su información personal aí como las opciones de edición 
/// [ birthDateFormated ] es la fecha del usuario formateada
/// en este archivo también se procesan las acciones del borrado y edicion
///




class InfoUserEditDelete extends StatefulWidget {
  final User user;

  const InfoUserEditDelete({
    super.key,
    required this.user,
  });

  @override
  State<InfoUserEditDelete> createState() => _InfoUserEditDeleteState();
}

class _InfoUserEditDeleteState extends State<InfoUserEditDelete> {
  bool borderColor = false; // Agrega una variable para el color del borde

  @override
  Widget build(BuildContext context) {

    final birthDateFormated = Utils.dateFormatter(widget.user.birthDate);

    return InkWell(
      borderRadius: BorderRadius.circular(21),
      onTap: () {
          
        borderColor =!borderColor; // Cambia el color del borde al tocar
        setState(() {
        
        });
        
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2, 15, 5),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 242, 241, 241),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor
                  ? const Color.fromARGB(255, 21, 20, 20)
                  : const Color.fromARGB(255, 236, 234, 234),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoUserLeft(user: widget.user, birthDateFormated: birthDateFormated),
                _ButtonerRigth(user: widget.user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





///
/// Zona derecha de la botonera: EDIT / DELETE / NEXT obtenemos como parámetro el [user] usuario sobre el que queremos realizar acciones
/// usamos nuestra clase servicio de provider con el objeto [userProvider] permanecemos subscritos a los cambios y procesamos metodos
/// como [findUser] busqueda del usuario solicitado
///      [deleteUser] borrado del usuario
///      [idUserEdited]-> propiedad en la que establecemos el id del usuario en el servicio ya disponible en el contexto
/// 


class _ButtonerRigth extends StatelessWidget {
  
  final User user;

  const _ButtonerRigth({
                           required this.user
                      });

  @override
  Widget build(BuildContext context) {
    
        final userProvider = context.watch<UserProvider>();

    return Row(


          children: [
            IconButton(
                     icon: const Icon(Icons.edit),
                     style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(30),
                                iconColor: MaterialStateProperty.all(Colors.grey), // Color del icono
                                ),
                                onPressed:  () async {                                    

                                        userProvider.findUser(user.id).then( (User user) {

                                            userProvider.idUserEdited = user.id;

                                            HelperModal.fireModal(context, 'EDIT');
                                        });

                                            } 
                          ),
            
            IconButton(
                   icon: const Icon(Icons.delete),
                   style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(37),
                                iconColor: MaterialStateProperty.all(const Color.fromARGB(255, 142, 19, 19)), // Color del icono
                                ),
                                onPressed: (){

                                        userProvider.deleteUser(user.id.toString());
                                     
                                            },
            ),
            
            IconButton(
                    icon: const Icon(Icons.chevron_right),
                    style: ButtonStyle(
                                iconSize: MaterialStateProperty.all(50),
                                iconColor: MaterialStateProperty.all(Colors.blue.shade900), // Color del icono
                                ),
                                onPressed: (){

                                        // TODO: NEXT no hay especificaciones de su funcionamiento
                                       
                                            },
                  ),
                
          ],
        );
  }
}





///
/// Zona izquierda muestra la información de cada usuario ( name, surname, birthdate, gender )
///
class _InfoUserLeft extends StatelessWidget {
  const _InfoUserLeft({
    required this.user,
    required this.birthDateFormated,
  });

  final User user;
  final String birthDateFormated;

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [


       Text( '${user.fullName} ${user.surname}', style:  TextStyle(
                                                                     fontSize: '${user.fullName} ${user.surname}'.length > 31 ? 9 : 13,
                                                                     fontWeight: FontWeight.w800,
                                                                           ), ),
        Row(
              children: [
              const Text( 'Birthdate: ', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800), ),
              Text( birthDateFormated, style: const TextStyle(fontSize: 12,), ),
              ],
          ), 
      Row(
            children: [
            const Text( 'Genero: ' , style: TextStyle(fontSize: 13,fontWeight: FontWeight.w800) ),
            Text(  user.gender.stringValue , style: const TextStyle(fontSize: 13) ),

              ],
      ),                                                                          
     ],
                              );
  }
}