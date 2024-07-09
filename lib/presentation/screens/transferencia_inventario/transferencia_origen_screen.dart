import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/validate_provider.dart';
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
                    textFieldAlmacenVerify(_controllerAlmacen)),
            UbicacionRow(
                colorQAD: colorQAD,
                textFieldUbicacionVerify:
                    textFieldUbicacionVerify(_controllerUbiOrig),
                iconButton: () async {

                  final descLoc = await GetLocApiDatasource().validateLoc(
                      Preferences.dominio,
                      Preferences.almacen,
                      _controllerUbiOrig.text);

                  ref.read(validateLocProvider.notifier).state =
                      descLoc.isEmpty ? false : true;
                  print(validateLoc);

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

                      ref.read(validatePartProvider.notifier).state =
                          descPart.isEmpty ? false : true;
                      print(validatePart);

                    })
                : Container(),
            validatePart 
            ?
            LoteRow(
                colorQAD: colorQAD,
                textFieldLoteOrigen: textFieldLoteOrigen(_controllerLoteOrig))
            : Container(),
            validatePart ?
            ReferenciaRow(
                colorQAD: colorQAD,
                textFieldReferenciaOrigen:
                    textFieldReferenciaOrigen(_controllerRefOrig))
            : Container(),
            validatePart ?
            CantidadRow(
                colorQAD: colorQAD,
                textFieldCantidad: textFieldCantidad(_controllerCantidad))
            : Container(),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  /*ref.read(transfChangeNotifierProvider.notifier).addTransf(
                      _controllerArticulo.text,
                      _controllerUbiOrig.text,
                      _controllerLoteOrig.text,
                      _controllerRefOrig.text,
                      int.parse(_controllerCantidad.text));

                  context.go('/transf-inv');*/
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
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

TextFormField textFieldAlmacenVerify(TextEditingController controllerAlmacen) {
  return TextFormField(
    controller: controllerAlmacen,
    readOnly: true,
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

TextFormField textFieldCantidad(TextEditingController controllerCantidad) {
  return TextFormField(
    controller: controllerCantidad,
    keyboardType: const TextInputType.numberWithOptions(),
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

InputDecoration inputDecorationTextFormField() {
  return InputDecoration(
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
  );
}
