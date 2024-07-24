import 'package:flutter/material.dart';

class ErrorTextValidate extends StatelessWidget {

  const ErrorTextValidate({super.key});
  @override
  Widget build(BuildContext context) {

    return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(children: [
                      const SizedBox(
                        //height: 60,
                        width: 110,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          //color: Colors.blue,
                          //height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                              'Cantidad Debe Ser distinta de Cero',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ),
                      ),
                    ]),
                  );
  }
}
