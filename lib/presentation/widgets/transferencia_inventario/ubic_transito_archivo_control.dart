import 'package:flutter/material.dart';

class UbicacionTransitoArchivoControl extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldUbicTransito;

  const UbicacionTransitoArchivoControl({super.key, required this.colorQAD, required this.textFieldUbicTransito});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 70,
              alignment: Alignment.centerLeft,
              //color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Ubicación Transito:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldUbicTransito,
            ),
          ),
          /*Expanded(
            flex: 1,
            child: IconButton(
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.red,
                ),
                iconSize: 35,
                color: colorQAD,
                onPressed: () {}),
          ),*/
        ],
      ),
    );
  }
}