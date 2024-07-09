import 'package:flutter/material.dart';

class ArticuloRow extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldArticuloVerify;
  final void Function()? iconButton;

  const ArticuloRow(
      {super.key,
      required this.colorQAD,
      required this.textFieldArticuloVerify,
      required this.iconButton});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 65,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Artículo:',
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
            child: textFieldArticuloVerify,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              icon: const Icon(
                Icons.check_circle_outline,
                color: Colors.red,
              ),
              iconSize: 35,
              color: colorQAD,
              onPressed: iconButton
              ),
        ),
      ],
    );
  }
}
//await GetPartApiDatasource().validatePart();