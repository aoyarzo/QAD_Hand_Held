import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class ProveedorRow extends ConsumerWidget {
  final Color colorQAD;
  //final TextFormField textFieldCantidad;

  const ProveedorRow({super.key, required this.colorQAD});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final ordenCodProv = ref.watch(ordenCodProvProvider);
    final ordenNombreProv = ref.watch(ordenNombreProvProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 110,
            alignment: Alignment.centerLeft,
            //color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Proveedor:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Cod: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(ordenCodProv, style: const TextStyle(fontSize: 12))
                  ],
                ),
                Text(ordenNombreProv, style: const TextStyle(fontSize: 12)),
              ],
            )
          ),
        ],
      ),
    );
  }
}
