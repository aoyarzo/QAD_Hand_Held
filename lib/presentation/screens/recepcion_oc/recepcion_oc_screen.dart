import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/infraestructure/datasources/recepcion_oc/val_det_oc_api_datasource.dart';
import 'package:qad_hand_held/infraestructure/datasources/recepcion_oc/val_oc_api_datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class RecepcionOCScreen extends ConsumerWidget {
  static const name = 'recepcion-oc-screen';
  RecepcionOCScreen({super.key});

  final _controllerOrden = TextEditingController();
  final _controllerDocumento = TextEditingController();
  final _controllerArticulo = TextEditingController();
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

    final validateOrden = ref.watch(validateOrdenProvider);
    final validateArt = ref.watch(validateDetOCProvider);

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
            const SizedBox(height: 5),
            OrdenRow(
                colorQAD: colorQAD,
                textFieldOrden: textFieldOrden(_controllerOrden),
                iconButton: () async {

                  final descLoc = await ValOCApiDatasource().validateOC(
                          Preferences.dominio, _controllerOrden.text);

                      ref.read(validateOrdenProvider.notifier).state =
                          descLoc[0].codProv.isEmpty ? false : true;

                      ref.read(ordenCodProvProvider.notifier).state =
                          descLoc[0].codProv;
                      ref.read(ordenNombreProvProvider.notifier).state =
                          descLoc[0].nombre;

                      print(descLoc);

                }),
            validateOrden ? ProveedorRow(colorQAD: colorQAD) : Container(),
            validateOrden
                ? DocumentoRow(
                    colorQAD: colorQAD,
                    textFieldDocumento:
                        textFieldDocumento(_controllerDocumento))
                : Container(),
            validateOrden
                ? ArticuloRecepcionOCRow(
                    colorQAD: colorQAD,
                    textFieldArticulo:
                        textFieldArticuloRecepcionOC(_controllerArticulo),
                    iconButton: () async {
                      
                      final descArt = await ValDetOCDatasource().validateDetOC(
                      Preferences.dominio,
                      _controllerOrden.text,
                      _controllerArticulo.text);

                  ref.read(validateDetOCProvider.notifier).state =
                      descArt[0].descripcion.isEmpty ? false : true;

                  ref.read(descripcionProvider.notifier).state =
                      descArt[0].descripcion;
                  ref.read(cantAbiertaProvider.notifier).state =
                      descArt[0].cantAbta;
                  ref.read(precioProvider.notifier).state =
                      descArt[0].precio;    

                  print(descArt);

                    })
                : Container(),
            validateArt ? validateOrden
                ? ArticuloResponseRow(colorQAD: colorQAD)
                : Container() :  Container(),
            validateArt ? validateOrden
                ? LoteRecepcionOCRow(
                    colorQAD: colorQAD,
                    textFieldLote: textFieldLoteRecepcionOC(_controllerLote))
                : Container() : Container(),
            validateArt ? validateOrden
                ? ReferenciaRecepcionRow(
                    colorQAD: colorQAD,
                    textFieldReferencia:
                        textFieldReferenciaRecepcionOC(_controllerRef))
                : Container() : Container(),
            validateArt ? validateOrden
                ? PrecioFacturaRow(
                    colorQAD: colorQAD,
                    textFieldPrecioFactura:
                        textFieldPrecioFactura(_controllerPrecioFactura))
                : Container() : Container(),
            validateArt ? validateOrden
                ? FechaVencimientoRow(
                    colorQAD: colorQAD,
                    textFieldFechaVenc:
                        textFieldFechaVenc(_controllerFechaVenc))
                : Container() : Container(),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                child: const Text(
                  'Confirmar',
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

TextFormField textFieldDocumento(TextEditingController controllerDocumento) {
  return TextFormField(
      controller: controllerDocumento,
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
