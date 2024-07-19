import 'package:flutter/material.dart';

class LoteAjusteInvRow extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldLote;

  const LoteAjusteInvRow({super.key, required this.colorQAD, required this.textFieldLote});
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
              child: Text('Lote:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldLote,
            ),
          ),
        ],
      ),
    );
  }
}
