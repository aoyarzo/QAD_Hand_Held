import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class AlmacenArchivoControl extends ConsumerWidget {
  final Color colorQAD;
  final TextFormField textFieldAlmacen;
  final void Function()? iconButton;

  const AlmacenArchivoControl({
    super.key, 
    required this.colorQAD, 
    required this.textFieldAlmacen,
    required this.iconButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final validateSite = ref.watch(validateSiteProvider);

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
                child: Text('Almacén:',
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
              child: textFieldAlmacen,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: validateSite ? Colors.green : Colors.red,
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
