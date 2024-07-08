import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/providers/transferencia_provider.dart';
import 'package:qad_hand_held/presentation/screens/screens.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';

class TransferenciaInventarioScreen extends ConsumerWidget {
  static const name = 'transf-inv-screen';

  const TransferenciaInventarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    //var textStyleTituloRow = const TextStyle(fontSize: 13, fontWeight: FontWeight.w600);

    final transf = ref.watch(transfChangeNotifierProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: colorQAD,
            title: Row(
              children: [
                const Text('Transferencia Inventario',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(width: 5),
                IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: 35,
                    color: Colors.white,
                    onPressed: () {
                      context.go('/trans-origen');

                      print(transf.transf.length);
                      for (int i = 0; i < transf.transf.length; i++) {
                        print(transf.transf[i].articulo);
                      }
                      //print(todos[0].articulo);
                    }),
              ],
            ),
          )),
      drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              //color: Colors.red,
              width: double.infinity,
              //height: double.infinity,
              child: Lista_Articulos(transf),
            ),
          ],
        ),
      ),
    );
  }
}

ListView Lista_Articulos(TransfChangeNotifier transf) {
  //tarjas_temp = dbProvider.tarjas;
  //buscarEmpleado('', dbProvider);
  final transfList = transf.transf;

  return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: transfList.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        var textStyleTituto = const TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600);
        var textStyleDato =
            const TextStyle(color: Colors.black87, fontSize: 12);

        return GestureDetector(
          onTap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TransferenciaDestinoScreen(
                            transfList[index].articulo, 
                            transfList[index].almOrig, 
                            transfList[index].ubiOrig, 
                            transfList[index].lotOrig, 
                            transfList[index].refOrig, 
                            transfList[index].cantidad)));
          },
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: transfList[index].articulo == 'Enviado'
                        ? const Color(0xFFFEE4E4)
                        : const Color(0xFFDFFBCB),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                //height: 25,
                                child: Text('Linea:', style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                alignment: Alignment.center,
                                //height: 25,
                                child: Text((index + 1).toString(),
                                    style: textStyleDato)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                //height: 25,
                                child:
                                    Text('Dominio:', style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                alignment: Alignment.center,
                                //height: 25,
                                child: Text(transfList[index].dominio,
                                    style: textStyleDato)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                //height: 25,
                                child:
                                    Text('Almacén:', style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                alignment: Alignment.center,
                                //height: 25,
                                child: Text(transfList[index].almOrig,
                                    style: textStyleDato)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                //width: 100,
                                child:
                                    Text('Artículo:', style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                //color: Colors.red,
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                width: 100,
                                child: Text(transfList[index].articulo,
                                    style: textStyleDato)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                //width: 100,
                                child: Text('Lote:', style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                width: 80,
                                child: Text(transfList[index].lotOrig,
                                    style: textStyleDato)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                //width: 100,
                                child:
                                    Text('Ubicación:', style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                //color: Colors.red,
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                width: 89,
                                child: Text(transfList[index].ubiOrig,
                                    style: textStyleDato)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                //width: 100,
                                child: Text('Referencia:',
                                    style: textStyleTituto)),
                            const SizedBox(width: 5),
                            Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                //width: 80,
                                child: Text(transfList[index].refOrig,
                                    style: textStyleDato)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            //height: 20,
                            //width: 100,
                            child: Text('Cantidad:', style: textStyleTituto)),
                        const SizedBox(width: 5),
                        Container(
                            alignment: Alignment.centerLeft,
                            //height: 20,
                            width: 80,
                            child: Text(transfList[index].cantidad.toString(),
                                style: textStyleDato)),
                      ],
                    ),
                  ],
                )),
          ),
        );
      });
}

TextFormField textFieldArticulo() {
  return TextFormField(
    //controller: _controllerAlmacen,
    //autocorrect: false,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black38, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: Colors.grey[300],
      //labelText: 'Almacen',
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black38, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}
