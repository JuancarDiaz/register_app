import 'package:flutter/material.dart';



class MessageInfo extends StatelessWidget {

  final String operation ;

  const MessageInfo({
                      super.key,
                      required this.operation
                    });

  @override
  Widget build(BuildContext context) {

    return  Center(
          child: Positioned(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
              child: Container(
                width: 500,  // Ancho del cuadrado
                height: 80, // Alto del cuadrado
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 126, 207, 130), // Color del cuadrado
                  borderRadius: BorderRadius.circular(20),   // Radio de los bordes
                ),
                child:  Center(
                  
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                        const Icon(
                                            Icons.thumb_up,
                                            size: 30, // Tamaño del icono
                                            color: Color.fromARGB(255, 8, 138, 8), // Color del icono
                                          ),
                                          const SizedBox(width: 15),
                                      Text('Patient successfully $operation')
                    ],
                  
                  )
                  ),
              ),
            ),
          ),
        );


  
  }
}