import 'package:flutter/material.dart';

class CantidadRow extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldCantidad;

  const CantidadRow({super.key, required this.colorQAD, required this.textFieldCantidad});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 65,
            width: 100,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Cantidad:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldCantidad,
            ),
          ),
        ],
      ),
    );
  }
}
