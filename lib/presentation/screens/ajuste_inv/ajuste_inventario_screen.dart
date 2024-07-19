import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class AjusteInventarioScreen extends ConsumerWidget {
  static const name = 'ajuste-inv-screen';
  AjusteInventarioScreen({super.key});

  final _controllerUbicacion = TextEditingController();
  final _controllerArticulo = TextEditingController();
  final _controllerLote = TextEditingController();
  final _controllerReferencia = TextEditingController();
  final _controllerCantidad = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    var textStyleTituto = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
    var textStyleDato = const TextStyle(color: Colors.black87, fontSize: 12);

    final validateLoc = ref.watch(validateLocAjusteInvProvider);
    final validateArt = ref.watch(validateArtAjusteInvProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
              backgroundColor: colorQAD,
              title: const Row(
                children: [
                  Text('Ajuste Inventario',
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
            UbicacionAjusteInv(
                colorQAD: colorQAD,
                textFieldUbicacion:
                    textFieldUbicacionAjusteInv(_controllerUbicacion),
                iconButton: () async {
                  final descLoc = await GetLocApiDatasource().validateLoc(
                      Preferences.dominio,
                      Preferences.almacen,
                      _controllerUbicacion.text);

                  ref.read(validateLocAjusteInvProvider.notifier).state =
                      descLoc.isEmpty ? false : true;
                }),
            validateLoc
                ? ArticuloAjusteInvRow(
                    colorQAD: colorQAD,
                    textFieldArticulo:
                        textFieldArticuloAjusteInv(_controllerArticulo),
                    iconButton: () async {
                      final descPart = await GetPartApiDatasource()
                          .validatePart(
                              Preferences.dominio, _controllerArticulo.text);

                      ref.read(validateArtAjusteInvProvider.notifier).state =
                          descPart[0].descripcion.isEmpty ? false : true;

                      ref.read(descripcionArtAjusteInvProvider.notifier).state =
                          descPart[0].descripcion;

                      ref.read(umArtAjusteInvProvider.notifier).state =
                          descPart[0].um;
                    })
                : Container(),
            validateArt
                ? ArticuloResponseAjusteInvRow(colorQAD: colorQAD)
                : Container(),
            validateArt
                ? LoteAjusteInvRow(
                    colorQAD: colorQAD,
                    textFieldLote: textFieldLoteAjusteInv(_controllerLote))
                : Container(),
            validateArt
                ? ReferenciaAjusteInvRow(
                    colorQAD: colorQAD,
                    textFieldReferencia:
                        textFieldReferenciaAjusteInv(_controllerReferencia))
                : Container(),
            validateArt
                ? CantidadAjusteInvRow(
                    colorQAD: colorQAD,
                    textFieldCantidad:
                        textFieldCantidadAjusteInv(_controllerCantidad))
                : Container(),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  final ajusteInv = await AjusInvDatasource().ajusInv(
                      Preferences.dominio,
                      _controllerArticulo.text,
                      Preferences.almacen,
                      _controllerUbicacion.text,
                      _controllerLote.text,
                      _controllerReferencia.text,
                      double.parse(_controllerCantidad.text),
                      Preferences.usuario);

                  print(ajusteInv);
                  ref.read(responseAjusteInvProvider.notifier).state =
                      ajusteInv[0].mensaje;

                  _controllerUbicacion.clear();
                  _controllerArticulo.clear();
                  _controllerLote.clear();
                  _controllerReferencia.clear();
                  _controllerCantidad.clear();
                  ref.read(validateLocAjusteInvProvider.notifier).state = false;
                  ref.read(validateArtAjusteInvProvider.notifier).state = false;

                  await _mensajeResponse(context, colorQAD, ref);
                },
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

TextFormField textFieldUbicacionAjusteInv(
    TextEditingController controllerUbicacion) {
  return TextFormField(
      controller: controllerUbicacion,
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

TextFormField textFieldArticuloAjusteInv(
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

TextFormField textFieldLoteAjusteInv(TextEditingController controllerLote) {
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

TextFormField textFieldReferenciaAjusteInv(
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

TextFormField textFieldCantidadAjusteInv(
    TextEditingController controllerCantidad) {
  return TextFormField(
      controller: controllerCantidad,
      keyboardType: TextInputType.number,
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

Future<void> _mensajeResponse(
    BuildContext context, Color colorQAD, WidgetRef ref) {
  final respuesta = ref.watch(responseAjusteInvProvider);

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
              const Text('¡Registro Enviado Exitosamente!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                respuesta,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
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
