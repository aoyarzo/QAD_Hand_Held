import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';

class ConsultaResponseRow extends ConsumerWidget {
  final Color colorQAD;
  //final TextFormField textFieldCantidad;

  const ConsultaResponseRow({super.key, required this.colorQAD});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final consulta = ref.watch(responseConsultaChangeNotifierProvider);

    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          color: Colors.yellow,
          width: 300,
          height: 180,
          child: ListView.builder(
            itemCount: consulta.consulta.length,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  Text('LoteSerie: '),
                  Text('Referencia:'),
                  Text('Cant Inv:'),
                  Text('Cant Asig:'),
                  Text('Cant Disp:')
                ],
              );
            },
          ),
        ));
  }
}
