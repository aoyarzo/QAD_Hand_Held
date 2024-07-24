import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class ArticuloResponseEntradaSalidaRow extends ConsumerWidget {
  final Color colorQAD;
  //final TextFormField textFieldCantidad;

  const ArticuloResponseEntradaSalidaRow({super.key, required this.colorQAD});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final descArt = ref.watch(descripcionArtAjusteInvProvider);
    final umArt = ref.watch(umArtAjusteInvProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 110,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Detalle:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(descArt, style: const TextStyle(fontSize: 12)),
                Row(
                  children: [
                    const Text('UM: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(umArt, style: const TextStyle(fontSize: 12))
                  ],
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
