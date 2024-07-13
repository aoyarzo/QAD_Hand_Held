import 'package:flutter/material.dart';

class UbicacionDestinoRow extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldUbicacionDestino;

  const UbicacionDestinoRow({super.key, required this.colorQAD, required this.textFieldUbicacionDestino});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          const Text('Ubicación Destino:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Container(
            //color: Colors.blue,
            height: 50,
            alignment: Alignment.center,
            child: textFieldUbicacionDestino,
          ),
        ],
      ),
    );
  }
}
