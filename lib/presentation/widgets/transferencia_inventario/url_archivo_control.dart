import 'package:flutter/material.dart';

class UrlArchivoControl extends StatelessWidget {
  final Color colorQAD;
  final TextFormField textFieldUrl;

  const UrlArchivoControl({super.key, required this.colorQAD, required this.textFieldUrl});
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
              child: Text('Url:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldUrl,
            ),
          ),
        ],
      ),
    );
  }
}
