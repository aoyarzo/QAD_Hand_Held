import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class ArticuloRow extends ConsumerWidget {
  final Color colorQAD;
  final TextFormField textFieldArticuloVerify;
  final void Function()? iconButton;

  const ArticuloRow(
      {super.key,
      required this.colorQAD,
      required this.textFieldArticuloVerify,
      required this.iconButton});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final validatePart = ref.watch(validatePartProvider);

    return Row(
      children: [
        Container(
          height: 65,
          width: 100,
          alignment: Alignment.centerLeft,
          //color: Colors.green,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Artículo:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
              icon: Icon(
                Icons.check_circle_outline,
                color: validatePart ? Colors.green : Colors.red,
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