import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class TransferenciaInventarioScreen extends ConsumerWidget {
  static const name = 'transf-inv-screen';
  final _controllerAlmacenDestino = TextEditingController();
  final _controllerUbicacionDestino = TextEditingController();

  TransferenciaInventarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    var textStyleTituto = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
    var textStyleDato = const TextStyle(color: Colors.black87, fontSize: 12);

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
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          //height: 25,
                          child: Text('Almacén:', style: textStyleTituto)),
                      const SizedBox(width: 2),
                      Container(
                          alignment: Alignment.center,
                          //height: 25,
                          child:
                              Text(Preferences.almacen, style: textStyleDato)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          //height: 25,
                          child: Text('Transito:', style: textStyleTituto)),
                      const SizedBox(width: 2),
                      Container(
                          alignment: Alignment.center,
                          //height: 25,
                          child: Text(Preferences.ubicTrans,
                              style: textStyleDato)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              //color: Colors.red,
              width: double.infinity,
              //height: double.infinity,
              child: listaArticulos(transf, ref),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: colorQAD,
          child: const Icon(Icons.check_box_outlined,
              size: 50, color: Colors.white),
          onPressed: () async {
            _showDialogConfirmar(
                context,
                textStyleTituto,
                colorQAD,
                textFieldAlmacenDestino(_controllerAlmacenDestino),
                textFieldUbicacionDestino(_controllerUbicacionDestino),
                ref,
                _controllerAlmacenDestino,
                _controllerUbicacionDestino);

            //await _mensajeResponse(context, colorQAD, ref);
          }),
    );
  }
}

ListView listaArticulos(TransfChangeNotifier transf, WidgetRef ref) {
  //tarjas_temp = dbProvider.tarjas;
  //buscarEmpleado('', dbProvider);
  final transfList = transf.transf;
  //final transf = ref.watch(transfChangeNotifierProvider);

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
            print(transfList[index].linea);
          },
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) async {
              //print(index);
              //transfList.removeWhere((element) => element.linea == index);

              final mensajeResponse = await TransferenciaApiDatasource()
                  .transferencia(
                      transfList[index].dominio,
                      transfList[index].articulo,
                      transfList[index].almOrig,
                      transfList[index].ubiDest,
                      transfList[index].lotOrig,
                      transfList[index].almDest,
                      transfList[index].ubiOrig,
                      transfList[index].refOrig,
                      transfList[index].cantidad,
                      transfList[index].usuario);
              print(mensajeResponse);

              ref
                  .read(transfChangeNotifierProvider.notifier)
                  .removeTransf(index + 1);
            },
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red[400],
              child: const Icon(
                Icons.delete_outlined,
                color: Colors.white,
              ),
            ),
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
                                  child:
                                      Text('Linea:', style: textStyleTituto)),
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
                                  //height: 20,
                                  //width: 100,
                                  child: Text('Artículo:',
                                      style: textStyleTituto)),
                              const SizedBox(width: 5),
                              Container(
                                  //color: Colors.red,
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 100,
                                  child: Text(transfList[index].articulo,
                                      style: textStyleDato)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  //height: 25,
                                  child: Text('Cantidad:',
                                      style: textStyleTituto)),
                              const SizedBox(width: 5),
                              Container(
                                  alignment: Alignment.center,
                                  //height: 25,
                                  child: Text(
                                      transfList[index].cantidad.toString(),
                                      style: textStyleDato)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 70,
                                  child: Text('Ubicación:',
                                      style: textStyleTituto)),
                              const SizedBox(width: 5),
                              Container(
                                  //color: Colors.red,
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 100,
                                  child: Text(transfList[index].ubiOrig,
                                      style: textStyleDato)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 100,
                                  child: Text('Lote:', style: textStyleTituto)),
                              const SizedBox(width: 5),
                              Container(
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 80,
                                  child: Text(transfList[index].lotOrig,
                                      style: textStyleDato)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 100,
                                  child: Text('Ref:', style: textStyleTituto)),
                              const SizedBox(width: 5),
                              Container(
                                  alignment: Alignment.center,
                                  //height: 20,
                                  //width: 80,
                                  child: Text(transfList[index].refOrig,
                                      style: textStyleDato)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  )),
            ),
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

Future<String?> _showDialogConfirmar(
    BuildContext context,
    TextStyle textStyleTituto,
    Color colorQAD,
    TextFormField textFieldAlmacenDestino,
    TextFormField textFieldUbicacionDestino,
    WidgetRef ref,
    TextEditingController _controllerAlmacen,
    TextEditingController _controllerUbicacion) async {
  final transf = ref.watch(transfChangeNotifierProvider);
  _controllerAlmacen.text = Preferences.almacen;
  return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Center(
                child: Text('Confirmar Transferencia',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
            content: SingleChildScrollView(
              child: SizedBox(
                height: 350,
                //width: 600,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      AlmacenDestinoRow(
                          colorQAD: colorQAD,
                          textFieldAlmacenDestino: textFieldAlmacenDestino),
                      const SizedBox(height: 20),
                      UbicacionDestinoRow(
                          colorQAD: colorQAD,
                          textFieldUbicacionDestino: textFieldUbicacionDestino),
                      const SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () async {
                            for (int i = 0; i < transf.transf.length; i++) {
                              final response =
                                  await TransferenciaApiDatasource()
                                      .transferencia(
                                          transf.transf[i].dominio,
                                          transf.transf[i].articulo,
                                          transf.transf[i].almOrig,
                                          Preferences.ubicTrans,
                                          transf.transf[i].lotOrig,
                                          _controllerAlmacen.text,
                                          _controllerUbicacion.text,
                                          transf.transf[i].refOrig,
                                          transf.transf[i].cantidad,
                                          transf.transf[i].usuario);

                              ref
                                  .read(responseTransfChangeNotifierProvider
                                      .notifier)
                                  .addRespuesta(
                                      response[0].number,
                                      response[0].mensaje,
                                      response[0].severidad);
                            }

                            ref
                                .read(transfChangeNotifierProvider.notifier)
                                .clearTransf();

                            Navigator.pop(context);

                            await _mensajeResponse(context, colorQAD, ref);

                            //context.go('/transf-inv');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorQAD),
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorQAD),
                          child: const Text(
                            ' Cancelar ',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

TextFormField textFieldAlmacenDestino(
    TextEditingController controllerAlmacenDestino) {
  return TextFormField(
    controller: controllerAlmacenDestino,
    //readOnly: true,
    //autocorrect: false,
    decoration: inputDecorationTextFormField(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldUbicacionDestino(
    TextEditingController controllerUbicacionDestino) {
  return TextFormField(
    controller: controllerUbicacionDestino,
    //readOnly: true,
    //autocorrect: false,
    decoration: inputDecorationTextFormField(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

Future<void> _mensajeResponse(
    BuildContext context, Color colorQAD, WidgetRef ref) {
  final respuesta = ref.watch(responseTransfChangeNotifierProvider);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(Icons.warning_rounded, size: 35, color: colorQAD),
        content: SizedBox(
          width: 80,
          height: 180,
          child: Column(
            children: [
              const Text('¡Registros Enviados Exitosamente!', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), 
              textAlign: TextAlign.center),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: respuesta.respuesta.length,
                itemBuilder: (context, index) {
                  return Text(respuesta.respuesta[index].mensaje,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                          textAlign: TextAlign.center,);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
            ],
          ),
        ),
      );
    },
  );
}