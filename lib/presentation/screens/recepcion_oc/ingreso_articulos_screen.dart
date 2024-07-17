import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/providers/recepcion_oc_provider.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class IngresoArticulosScreen extends ConsumerWidget {
  static const name = 'ingreso-arts-screen';
  IngresoArticulosScreen({super.key});

  final _controllerArticulo = TextEditingController();
  final _controllerCantidad = TextEditingController();
  final _controllerLote = TextEditingController();
  final _controllerRef = TextEditingController();
  final _controllerPrecioFactura = TextEditingController();
  final _controllerFechaVenc = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    var textStyleTituto = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
    var textStyleDato = const TextStyle(color: Colors.black87, fontSize: 12);
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    final orden = ref.watch(ordenProvider);
    final documento = ref.watch(documentoProvider);
    final validateArt = ref.watch(validateDetOCProvider);
    final ordenCodProv = ref.watch(ordenCodProvProvider);
    //final cantAbierta = ref.watch(cantAbiertaProvider);
    final recepcion_temp = ref.watch(recepcionOCChangeNotifierProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: colorQAD,
            title: Row(
              children: [
                const Text('Ingreso Artículos',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(width: 50),
                IconButton(
                    icon: const Icon(Icons.zoom_in_outlined),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      _showDialogRevisarArticulos(
                          context, textStyleTituto, colorQAD, ref);
                    }),
              ],
            ),
          )),
      drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
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
            ArticuloRecepcionOCRow(
                colorQAD: colorQAD,
                textFieldArticulo:
                    textFieldArticuloRecepcionOC(_controllerArticulo),
                iconButton: () async {
                  final descArt = await ValDetOCDatasource().validateDetOC(
                      Preferences.dominio, orden, _controllerArticulo.text);

                  ref.read(validateDetOCProvider.notifier).state =
                      descArt[0].descripcion.isEmpty ? false : true;

                  ref.read(descripcionProvider.notifier).state =
                      descArt[0].descripcion;
                  ref.read(cantAbiertaProvider.notifier).state =
                      descArt[0].cantAbta;
                  ref.read(precioProvider.notifier).state = descArt[0].precio;

                  print(descArt);
                }),
            validateArt ? ArticuloResponseRow(colorQAD: colorQAD) : Container(),
            validateArt
                ? CantidadRecepcionOCRow(
                    colorQAD: colorQAD,
                    textFieldCantidad:
                        textFieldCantidadRecepcionOC(_controllerCantidad))
                : Container(),
            validateArt
                ? LoteRecepcionOCRow(
                    colorQAD: colorQAD,
                    textFieldLote: textFieldLoteRecepcionOC(_controllerLote))
                : Container(),
            validateArt
                ? ReferenciaRecepcionRow(
                    colorQAD: colorQAD,
                    textFieldReferencia:
                        textFieldReferenciaRecepcionOC(_controllerRef))
                : Container(),
            validateArt
                ? PrecioFacturaRow(
                    colorQAD: colorQAD,
                    textFieldPrecioFactura:
                        textFieldPrecioFactura(_controllerPrecioFactura))
                : Container(),
            validateArt
                ? FechaVencimientoRow(
                    colorQAD: colorQAD,
                    textFieldFechaVenc: textFieldFechaVenc(
                      _controllerFechaVenc,
                    ),
                    iconButton: () async {
                      await showDatePicker(
                              context: context,
                              locale: const Locale('es', ''),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030))
                          .then((value) {
                        String formattedFechaVenc = formatter.format(value!);
                        _controllerFechaVenc.text = formattedFechaVenc;
                      });

                      //final DateTime now = DateTime.now();
                    })
                : Container(),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  print(recepcion_temp.recepcion.length + 1);
                  ref
                      .read(recepcionOCChangeNotifierProvider.notifier)
                      .addRecepcionOC(
                          recepcion_temp.recepcion.length + 1,
                          orden,
                          ordenCodProv,
                          formattedDate,
                          documento,
                          _controllerArticulo.text,
                          1,
                          double.parse(_controllerPrecioFactura.text),
                          double.parse(_controllerCantidad.text),
                          _controllerLote.text,
                          _controllerRef.text,
                          _controllerFechaVenc.text);

                  print(recepcion_temp.recepcion.length);

                  ref.read(validateDetOCProvider.notifier).state = false;
                  _controllerArticulo.clear();
                  _controllerCantidad.clear();
                  _controllerLote.clear();
                  _controllerRef.clear();
                  _controllerPrecioFactura.clear();
                  _controllerFechaVenc.clear();
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

TextFormField textFieldArticuloRecepcionOC(
    TextEditingController controllerArticulo) {
  return TextFormField(
      controller: controllerArticulo,
      //autocorrect: false,
      decoration: inputDecorationTextFormField()
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
      );
}

TextFormField textFieldCantidadRecepcionOC(
    TextEditingController controllerCantidad) {
  return TextFormField(
      controller: controllerCantidad,
      //autocorrect: false,
      decoration: inputDecorationTextFormField()
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
      );
}

TextFormField textFieldLoteRecepcionOC(TextEditingController controllerLote) {
  return TextFormField(
      controller: controllerLote,
      //autocorrect: false,
      decoration: inputDecorationTextFormField()
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
      );
}

TextFormField textFieldReferenciaRecepcionOC(
    TextEditingController controllerReferencia) {
  return TextFormField(
      controller: controllerReferencia,
      //autocorrect: false,
      decoration: inputDecorationTextFormField()
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
      );
}

TextFormField textFieldPrecioFactura(
    TextEditingController controllerPrecioFactura) {
  return TextFormField(
      controller: controllerPrecioFactura,
      //autocorrect: false,
      decoration: inputDecorationTextFormField()
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
      );
}

TextFormField textFieldFechaVenc(TextEditingController controllerFechaVenc) {
  return TextFormField(
      controller: controllerFechaVenc,
      readOnly: true,
      //autocorrect: false,
      decoration: inputDecorationTextFormField()
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      //onChanged: (value) => buscarTpago(value, dbProvider),
      );
}

Future<String?> _showDialogRevisarArticulos(BuildContext context,
    TextStyle textStyleTituto, Color colorQAD, WidgetRef ref) async {
  final recepcion = ref.watch(recepcionOCChangeNotifierProvider).recepcion;

  return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.zero,
            title: const Center(
                child: Text('Artículos Ingresados',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            content: SingleChildScrollView(
              child: SizedBox(
                height: 350,
                width: 100,
                child: Column(
                  children: [
                    SizedBox(
                        //color: Colors.blue,
                        height: 220,
                        child: listaArticulosRecepcionOC(ref)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          for (int i = 0; i < recepcion.length; i++) {
                            final recepcionOC = await RpcOCDatasource().rpcOC(
                                recepcion[i].dominio,
                                recepcion[i].orden,
                                recepcion[i].articulo,
                                recepcion[i].proveedor,
                                recepcion[i].funda,
                                recepcion[i].cantidad,
                                recepcion[i].costo,
                                recepcion[i].almacen,
                                recepcion[i].ubicacion,
                                recepcion[i].lote,
                                recepcion[i].referencia,
                                recepcion[i].fchVcto,
                                recepcion[i].usuario);
                            print(recepcionOC);
                          }

                          ref.read(validateDetOCProvider.notifier).state =
                              false;
                          ref.read(validateOrdenProvider.notifier).state =
                              false;
                          ref.read(recepcionOCChangeNotifierProvider.notifier)
                              .clearRecepcion();

                          context.go('/recepcion-oc');
                          
                        },
                        style:
                            ElevatedButton.styleFrom(backgroundColor: colorQAD),
                        child: const Text(
                          'Terminar',
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
                        style:
                            ElevatedButton.styleFrom(backgroundColor: colorQAD),
                        child: const Text(
                          ' Volver ',
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
        );
      });
}

ListView listaArticulosRecepcionOC(WidgetRef ref) {
  //tarjas_temp = dbProvider.tarjas;
  //buscarEmpleado('', dbProvider);
  //final transfList = transf.transf;
  final recepcion = ref.watch(recepcionOCChangeNotifierProvider).recepcion;

  return ListView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: recepcion.length,
      //separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        var textStyleTituto = const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
        var textStyleDato =
            const TextStyle(color: Colors.black87, fontSize: 12);

        return GestureDetector(
          onTap: () {
            print(recepcion[index].idRecepcion);
          },
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) async {
              //print('index: ' + index.toString());
              //print((recepcion[index].linea));
              ref
                  .read(recepcionOCChangeNotifierProvider.notifier)
                  .removeRecepcion(index + 1);
            },
            background: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[400]),
              alignment: AlignmentDirectional.centerEnd,
              //color: Colors.red[400],
              child: const Icon(
                Icons.delete_outlined,
                color: Colors.white,
              ),
            ),
            child: Container(
              //color: Colors.blue,
              padding: const EdgeInsets.all(5),
              //margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: recepcion[index].articulo == 'Enviado'
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
                              //color: Colors.red,
                              width: 20,
                              //height: 25,
                              child: Text((index + 1).toString(),
                                  style: textStyleTituto)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 100,
                              child: Text('Artículo:', style: textStyleTituto)),
                          const SizedBox(width: 5),
                          Container(
                              //color: Colors.red,
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 100,
                              child: Text(recepcion[index].articulo,
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
                              child: Text(recepcion[index].lote,
                                  style: textStyleDato)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              child: Text(recepcion[index].referencia,
                                  style: textStyleDato)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 100,
                              child: Text('Venc:', style: textStyleTituto)),
                          const SizedBox(width: 5),
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 80,
                              child: Text(recepcion[index].fchVcto.toString(),
                                  style: textStyleDato)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 100,
                              child: Text('Cant:', style: textStyleTituto)),
                          const SizedBox(width: 5),
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 80,
                              child: Text(recepcion[index].cantidad.toString(),
                                  style: textStyleDato)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 100,
                              child: Text('Precio:', style: textStyleTituto)),
                          const SizedBox(width: 5),
                          Container(
                              alignment: Alignment.center,
                              //height: 20,
                              //width: 80,
                              child: Text(recepcion[index].costo.toString(),
                                  style: textStyleDato)),
                        ],
                      ),
                    ],
                  ),
                  //const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      });
}