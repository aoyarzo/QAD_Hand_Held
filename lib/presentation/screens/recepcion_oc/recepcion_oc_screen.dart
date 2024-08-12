import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class RecepcionOCScreen extends ConsumerWidget {
  static const name = 'recepcion-oc-screen';
  RecepcionOCScreen({super.key});

  final _controllerOrden = TextEditingController();
  final _controllerDocumento = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    var textStyleTituto = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
    var textStyleDato = const TextStyle(color: Colors.black87, fontSize: 12);

    final validateOrden = ref.watch(validateOrdenProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
              backgroundColor: colorQAD,
              title: const Row(
                children: [
                  Text('Recepción OC',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(width: 5),
                ],
              ))),
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
            const SizedBox(height: 20),
            OrdenRow(
                colorQAD: colorQAD,
                textFieldOrden: textFieldOrden(_controllerOrden),
                iconButton: () async {
                  final descLoc = await ValOCApiDatasource()
                      .validateOC(Preferences.dominio, _controllerOrden.text);

                  if (descLoc[0].codProv.isEmpty) {
                    _mensajeErrorValidacion(
                        context, colorQAD, 'Orden No Encontrada');
                  } else {
                    ref.read(validateOrdenProvider.notifier).state = true;

                    ref.read(ordenCodProvProvider.notifier).state =
                        descLoc[0].codProv;
                    ref.read(ordenNombreProvProvider.notifier).state =
                        descLoc[0].nombre;
                    ref.read(ordenProvider.notifier).state =
                        _controllerOrden.text;
                    ref.read(documentoProvider.notifier).state =
                        _controllerDocumento.text;
                  }
                  //print(descLoc);
                },
                iconButtonScanner: () async {
                  String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);

                  final descLoc = await ValOCApiDatasource()
                      .validateOC(Preferences.dominio, barcodeScanRes);

                  if (descLoc[0].codProv.isEmpty) {
                    _mensajeErrorValidacion(
                        context, colorQAD, 'Orden No Encontrada');
                  } else {
                    ref.read(validateOrdenProvider.notifier).state = true;

                    ref.read(ordenCodProvProvider.notifier).state =
                        descLoc[0].codProv;
                    ref.read(ordenNombreProvProvider.notifier).state =
                        descLoc[0].nombre;
                    ref.read(ordenProvider.notifier).state =
                        _controllerOrden.text;
                    ref.read(documentoProvider.notifier).state =
                        _controllerDocumento.text;
                    _controllerOrden.text = barcodeScanRes;
                  }
                }),
            validateOrden ? ProveedorRow(colorQAD: colorQAD) : Container(),
            validateOrden
                ? DocumentoRow(
                    colorQAD: colorQAD,
                    textFieldDocumento: textFieldDocumento(
                        _controllerDocumento, validateOrden, ref))
                : Container(),
            const SizedBox(height: 30),
            ValueListenableBuilder(
              valueListenable: _controllerDocumento,
              builder: (context, value, child) {
                return ElevatedButton(
                    onPressed: _controllerDocumento.text.isNotEmpty &&
                            validateOrden
                        ? () async {
                            context.go('/ingreso-arts');
                            ref
                                .read(responseRecepcionChangeNotifierProvider
                                    .notifier)
                                .clearRecepcion();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ));
              },
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

TextFormField textFieldOrden(TextEditingController controllerOrden) {
  return TextFormField(
      controller: controllerOrden,
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

TextFormField textFieldDocumento(TextEditingController controllerDocumento,
    bool validateOrden, WidgetRef ref) {
  return TextFormField(
    controller: controllerDocumento,
    //autocorrect: false,
    decoration: inputDecorationTextFormField(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
  );
}

Future<void> _mensajeErrorValidacion(
    BuildContext context, Color colorQAD, String errorMsj) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(Icons.warning_rounded, size: 35, color: colorQAD),
        content: SizedBox(
          width: 80,
          height: 100,
          child: Column(
            children: [
              Text(errorMsj,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
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
