import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class TransferenciaOrigenScreen extends ConsumerWidget {
  static const name = 'trans-origen-screen';

  final _controllerArticulo = TextEditingController();
  final _controllerAlmacen = TextEditingController();
  final _controllerUbiOrig = TextEditingController();
  final _controllerLoteOrig = TextEditingController();
  final _controllerRefOrig = TextEditingController();
  final _controllerCantidad = TextEditingController();

  TransferenciaOrigenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);

    _controllerAlmacen.text = Preferences.almacen;
    final validateLoc = ref.watch(validateLocProvider);
    final validatePart = ref.watch(validatePartProvider);
    final transf = ref.watch(transfChangeNotifierProvider);
    final validateCantidad = ref.watch(validateCantidadTransfProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: colorQAD,
            title: const Text('Transferencia Origen',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            leading: IconButton(
                padding: const EdgeInsets.only(left: 5),
                onPressed: () {
                  context.go('/transf-inv');
                },
                icon: const Icon(Icons.arrow_back_outlined,
                    size: 26, color: Colors.white)),
          )),
      //drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AlmacenRow(
                colorQAD: colorQAD,
                textFieldAlmacenVerify:
                    textFieldAlmacenOrigen(_controllerAlmacen)),
            UbicacionRow(
                colorQAD: colorQAD,
                textFieldUbicacionVerify:
                    textFieldUbicacionVerify(_controllerUbiOrig),
                iconButton: () async {
                  final descLoc = await GetLocApiDatasource().validateLoc(
                      Preferences.dominio,
                      Preferences.almacen,
                      _controllerUbiOrig.text);

                  if (descLoc.isEmpty) {
                    await _mensajeErrorValidacion(
                        context, colorQAD, 'Ubicación No Encontrada');
                  } else {
                    ref.read(validateLocProvider.notifier).state = true;
                  }
                },
                iconButtonScanner: () async {
                  String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);
                  //print(barcodeScanRes);
                  final descLoc = await GetLocApiDatasource().validateLoc(
                      Preferences.dominio,
                      Preferences.almacen,
                      barcodeScanRes);

                  if (descLoc.isEmpty) {
                    await _mensajeErrorValidacion(
                        context, colorQAD, 'Ubicación No Encontrada');
                  } else {
                    ref.read(validateLocProvider.notifier).state = true;
                    _controllerUbiOrig.text = barcodeScanRes;
                  }
                }),
            validateLoc
                ? ArticuloRow(
                    colorQAD: colorQAD,
                    textFieldArticuloVerify:
                        textFieldArticuloVerify(_controllerArticulo),
                    iconButton: () async {
                      final descPart = await GetPartApiDatasource()
                          .validatePart(
                              Preferences.dominio, _controllerArticulo.text);

                      if (descPart[0].descripcion.isEmpty) {
                        _mensajeErrorValidacion(
                            context, colorQAD, 'Artículo No Encontrado');
                      } else {
                        ref.read(validatePartProvider.notifier).state = true;
                      }
                      //print(validatePart);
                    },
                    iconButtonScanner: () async {
                      String barcodeScanRes =
                          await FlutterBarcodeScanner.scanBarcode(
                              '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);

                      final descPart = await GetPartApiDatasource()
                          .validatePart(
                              Preferences.dominio, barcodeScanRes);

                      if (descPart[0].descripcion.isEmpty) {
                        _mensajeErrorValidacion(
                            context, colorQAD, 'Artículo No Encontrado');
                      } else {
                        ref.read(validatePartProvider.notifier).state = true;
                        _controllerArticulo.text = barcodeScanRes;
                      }
                    })
                : Container(),
            validatePart
                ? LoteRow(
                    colorQAD: colorQAD,
                    textFieldLoteOrigen:
                        textFieldLoteOrigen(_controllerLoteOrig))
                : Container(),
            validatePart
                ? ReferenciaRow(
                    colorQAD: colorQAD,
                    textFieldReferenciaOrigen:
                        textFieldReferenciaOrigen(_controllerRefOrig))
                : Container(),
            validatePart
                ? CantidadRow(
                    colorQAD: colorQAD,
                    textFieldCantidad:
                        textFieldCantidad(_controllerCantidad, ref))
                : Container(),
            validateCantidad ? const ErrorTextValidate() : Container(),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: _controllerCantidad,
              builder: (context, value, child) {
                return ElevatedButton(
                    onPressed: _controllerCantidad.text.isNotEmpty &&
                            validateLoc &&
                            validatePart
                        ? () async {
                            if (double.parse(_controllerCantidad.text) > 0) {
                              //Guarda en Provider
                              ref
                                  .read(transfChangeNotifierProvider.notifier)
                                  .addTransf(
                                      transf.transf.length + 1,
                                      _controllerArticulo.text,
                                      _controllerUbiOrig.text,
                                      _controllerLoteOrig.text,
                                      _controllerRefOrig.text,
                                      Preferences.ubicTrans,
                                      int.parse(_controllerCantidad.text));

                              //Valida Cantidad
                              final mensajeResponse =
                                  await TransferenciaApiDatasource()
                                      .transferencia(
                                          Preferences.dominio,
                                          _controllerArticulo.text,
                                          Preferences.almacen,
                                          _controllerUbiOrig.text,
                                          _controllerLoteOrig.text,
                                          Preferences.almacen,
                                          Preferences.ubicTrans,
                                          _controllerRefOrig.text,
                                          int.parse(_controllerCantidad.text),
                                          Preferences.usuario);

                              ref
                                  .read(responseTransfOrigenProvider.notifier)
                                  .state = mensajeResponse[0].mensaje;

                              ref.read(validatePartProvider.notifier).state =
                                  false;
                              ref.read(validateLocProvider.notifier).state =
                                  false;

                              //context.go('/transf-inv');

                              _mensajeResponse(context, colorQAD, ref);
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

TextFormField textFieldAlmacenOrigen(TextEditingController controllerAlmacen) {
  return TextFormField(
      controller: controllerAlmacen,
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

TextFormField textFieldUbicacionVerify(
    TextEditingController controllerUbicOrig) {
  return TextFormField(
    controller: controllerUbicOrig,
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

TextFormField textFieldArticuloVerify(
    TextEditingController controllerArticulo) {
  return TextFormField(
    controller: controllerArticulo,
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

TextFormField textFieldLoteOrigen(TextEditingController controllerLoteOrig) {
  return TextFormField(
    controller: controllerLoteOrig,
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

TextFormField textFieldReferenciaOrigen(
    TextEditingController controllerRefOrig) {
  return TextFormField(
    controller: controllerRefOrig,
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

TextFormField textFieldCantidad(
    TextEditingController controllerCantidad, WidgetRef ref) {
  return TextFormField(
    controller: controllerCantidad,
    keyboardType: const TextInputType.numberWithOptions(),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
    ],
    //autocorrect: false,
    decoration: inputDecorationTextFormField(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    onChanged: (value) {
      ref.read(validateCantidadTransfProvider.notifier).state =
          double.parse(value) != 0 ? false : true;
    },
  );
}

Future<void> _mensajeResponse(
    BuildContext context, Color colorQAD, WidgetRef ref) {
  final respuesta = ref.watch(responseTransfOrigenProvider);

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
                    context.go('/transf-inv');
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
