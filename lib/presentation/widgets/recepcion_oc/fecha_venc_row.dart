import 'package:flutter/material.dart';

class FechaVencimientoRow extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldFechaVenc;
  final void Function()? iconButton;

  const FechaVencimientoRow({super.key, required this.colorQAD, 
  required this.textFieldFechaVenc, required this.iconButton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 110,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Fecha \nVencimiento:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldFechaVenc,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined),
                iconSize: 35,
                color: colorQAD,
                onPressed: iconButton),
          ),
        ],
      ),
    );
  }
}
