import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/providers/transferencia_provider.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';

class TransferenciaOrigenScreen extends ConsumerWidget {
  static const name = 'trans-origen-screen';

  const TransferenciaOrigenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);

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
            ArticuloRow(
                colorQAD: colorQAD,
                textFieldArticuloVerify: textFieldArticuloVerify()),
            AlmacenRow(
                colorQAD: colorQAD,
                textFieldAlmacenVerify: textFieldAlmacenVerify()),
            UbicacionRow(
                colorQAD: colorQAD,
                textFieldUbicacionVerify: textFieldUbicacionVerify()),
            LoteRow(
                colorQAD: colorQAD, textFieldLoteOrigen: textFieldLoteOrigen()),
            ReferenciaRow(
                colorQAD: colorQAD,
                textFieldReferenciaOrigen: textFieldReferenciaOrigen()),
            CantidadRow(
                colorQAD: colorQAD, textFieldCantidad: textFieldCantidad()),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {

                ref.read(transfChangeNotifierProvider.notifier).addTransf();

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorQAD),
              child: const Text('Guardar', 
               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
               )),    
            
          ],
        ),
      ),

    );
  }
}

TextFormField textFieldArticuloVerify() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldAlmacenVerify() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldUbicacionVerify() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldLoteOrigen() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldReferenciaOrigen() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldAlmacenDestino() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldUbicacionDestino() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldLoteDestino() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldReferenciaDestino() {
  return TextFormField(
    //controller: _controllerAlmacen,
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

TextFormField textFieldCantidad() {
  return TextFormField(
    //controller: _controllerAlmacen,
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
