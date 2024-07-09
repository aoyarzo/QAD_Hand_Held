import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';


class UbicacionRow extends ConsumerWidget {
  final Color colorQAD;
  final TextFormField textFieldUbicacionVerify;
  final void Function()? iconButton;

  const UbicacionRow(
      {super.key,
      required this.colorQAD,
      required this.textFieldUbicacionVerify,
      required this.iconButton});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validateLoc = ref.watch(validateLocProvider);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 60,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Ubicación Origen:',
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
            child: textFieldUbicacionVerify,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              icon: Icon(
                Icons.check_circle_outline,
                color: validateLoc ? Colors.green : Colors.red,
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
