import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class ArticuloAjusteInvRow extends ConsumerWidget {
  final Color colorQAD;
  final TextFormField textFieldArticulo;
  final void Function()? iconButton;

  const ArticuloAjusteInvRow({
    super.key, 
    required this.colorQAD, 
    required this.textFieldArticulo,
    required this.iconButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final validateArt = ref.watch(validateArtAjusteInvProvider);

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
              child: Text('Artículo:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //color: Colors.blue,
              height: 50,
              alignment: Alignment.center,
              child: textFieldArticulo,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: validateArt ? Colors.green : Colors.red,
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
