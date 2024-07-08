import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/providers/transferencia_provider.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';

class TransferenciaDestinoScreen extends ConsumerWidget {
  static const name = 'trans-destino-screen';

  final _controllerArticulo = TextEditingController();
  final _controllerUbiOrig = TextEditingController();
  final _controllerLoteOrig = TextEditingController();
  final _controllerRefOrig = TextEditingController();
  final _controllerCantidad = TextEditingController();

  final String articulo;
  final String almacen;
  final String ubicacion;
  final String lote;
  final String referencia;
  final int cantidad;

  TransferenciaDestinoScreen(this.articulo, this.almacen, this.ubicacion,
      this.lote, this.referencia, this.cantidad,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);

    _controllerArticulo.text = articulo;
    _controllerUbiOrig.text = ubicacion;
    _controllerLoteOrig.text = lote;
    _controllerRefOrig.text = referencia;
    _controllerCantidad.text = cantidad.toString();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: colorQAD,
            title: const Text('Transferencia Destino',
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
            ArticuloRow(
                colorQAD: colorQAD,
                textFieldArticuloVerify:
                    textFieldArticuloConfirmacion(_controllerArticulo)),
            AlmacenRow(
                colorQAD: colorQAD,
                textFieldAlmacenVerify: textFieldAlmacenOrigenConfirmacion()),
            UbicacionRow(
                colorQAD: colorQAD,
                textFieldUbicacionVerify:
                    textFieldUbicacionOrigenConfirmacion(_controllerUbiOrig)),
            LoteRow(
                colorQAD: colorQAD,
                textFieldLoteOrigen:
                    textFieldLoteOrigenConfirmacion(_controllerLoteOrig)),
            ReferenciaRow(
                colorQAD: colorQAD,
                textFieldReferenciaOrigen:
                    textFieldReferenciaOrigenConfirmacion(_controllerRefOrig)),
            AlmacenDestinoRow(
                colorQAD: colorQAD,
                textFieldAlmacenDestino: textFieldAlmacenDestino()),
            UbicacionDestinoRow(
                colorQAD: colorQAD,
                textFieldUbicacionDestino:
                    textFieldUbicacionDestino()),
            LoteDestinoRow(
                colorQAD: colorQAD,
                textFieldLoteDestino:
                    textFieldLoteDestino()),
            ReferenciaDestinoRow(
                colorQAD: colorQAD,
                textFieldReferenciaDestino:
                    textFieldReferenciaDestino()),
            CantidadRow(
                colorQAD: colorQAD,
                textFieldCantidad:
                    textFieldCantidadConfirmacion(_controllerCantidad)),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  ref.read(transfChangeNotifierProvider.notifier).addTransf(
                      _controllerArticulo.text,
                      _controllerUbiOrig.text,
                      _controllerLoteOrig.text,
                      _controllerRefOrig.text,
                      int.parse(_controllerCantidad.text));
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                child: const Text(
                  'Confirmar',
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

TextFormField textFieldAlmacenDestino() {
  return TextFormField(
    //controller: _controllerAlmacen,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldUbicacionDestino() {
  return TextFormField(
    //controller: controllerUbicOrig,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldLoteDestino() {
  return TextFormField(
    //controller: controllerLoteOrig,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldReferenciaDestino() {
  return TextFormField(
    //controller: controllerRefOrig,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldCantidadDestino(
    TextEditingController controllerCantidad) {
  return TextFormField(
    controller: controllerCantidad,
    keyboardType: const TextInputType.numberWithOptions(),
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldArticuloConfirmacion(
    TextEditingController controllerArticulo) {
  return TextFormField(
    controller: controllerArticulo,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldAlmacenOrigenConfirmacion() {
  return TextFormField(
    //controller: _controllerAlmacen,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldUbicacionOrigenConfirmacion(
    TextEditingController controllerUbicOrig) {
  return TextFormField(
    controller: controllerUbicOrig,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldLoteOrigenConfirmacion(
    TextEditingController controllerLoteOrig) {
  return TextFormField(
    controller: controllerLoteOrig,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldReferenciaOrigenConfirmacion(
    TextEditingController controllerRefOrig) {
  return TextFormField(
    controller: controllerRefOrig,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldCantidadConfirmacion(
    TextEditingController controllerCantidad) {
  return TextFormField(
    controller: controllerCantidad,
    keyboardType: const TextInputType.numberWithOptions(),
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldDestino(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

InputDecoration inputDecorationTextFormFieldDestino() {
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
