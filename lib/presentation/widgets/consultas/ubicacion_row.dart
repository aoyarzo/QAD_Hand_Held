import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UbicacionConsulta extends ConsumerWidget {
  final Color colorQAD;
  final TextFormField textFieldUbicacion;

  const UbicacionConsulta(
      {super.key,
      required this.colorQAD,
      required this.textFieldUbicacion});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 100,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Ubicación:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldUbicacion,
            ),
          ),
        ],
      ),
    );
  }
}
