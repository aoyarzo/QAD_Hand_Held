import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class ArticuloResponseRow extends ConsumerWidget {
  final Color colorQAD;
  //final TextFormField textFieldCantidad;

  const ArticuloResponseRow({super.key, required this.colorQAD});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final descripcion = ref.watch(descripcionProvider);
    final cantAbierta = ref.watch(cantAbiertaProvider);
    final precio = ref.watch(precioProvider);

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
                Text(descripcion, style: const TextStyle(fontSize: 12)),
                Row(
                  children: [
                    const Text('Cant. Abierta: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('$cantAbierta', style: const TextStyle(fontSize: 12))
                  ],
                ),
                Row(
                  children: [
                    const Text('Precio: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('$precio', style: const TextStyle(fontSize: 12))
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
