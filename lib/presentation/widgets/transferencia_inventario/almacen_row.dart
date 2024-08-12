import 'package:flutter/material.dart';
//import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';

class AlmacenRow extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldAlmacenVerify;

  const AlmacenRow(
      {super.key,
      required this.colorQAD,
      required this.textFieldAlmacenVerify});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 65,
          width: 100,
          alignment: Alignment.centerLeft,
          //color: Colors.green,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Almacén Origen:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            //color: Colors.blue,
            height: 50,
            alignment: Alignment.center,
            child: textFieldAlmacenVerify,
          ),
        ),
        
      ],
    );
  }
}
