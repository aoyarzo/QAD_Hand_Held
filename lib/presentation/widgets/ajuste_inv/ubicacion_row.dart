import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class UbicacionAjusteInv extends ConsumerWidget {
  final Color colorQAD;
  final TextFormField textFieldUbicacion;
  final void Function()? iconButton;
  final void Function()? iconButtonScanner;

  const UbicacionAjusteInv(
      {super.key,
      required this.colorQAD,
      required this.textFieldUbicacion,
      required this.iconButton,
      required this.iconButtonScanner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final validateLoc = ref.watch(validateLocAjusteInvProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 100,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Ubicación:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldUbicacion,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: const Icon(
                  Icons.qr_code_scanner_outlined,
                ),
                iconSize: 35,
                color: colorQAD,
                onPressed: iconButtonScanner),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: validateLoc ? Colors.green : Colors.red,
                ),
                iconSize: 35,
                color: colorQAD,
                onPressed: iconButton),
          ),
        ],
      ),
    );
  }
}
