import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';

class ArchivoControlScreen extends ConsumerWidget {
  static const name = 'archivo-control-screen';

  const ArchivoControlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: colorQAD,
            title: const Text('Archivo Control',
                style: TextStyle(
                    fontSize: 16,
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
            
            DominioArchivoControl(
              colorQAD: colorQAD, 
              textFieldDominio: textFieldDominio()),
            AlmacenArchivoControl(
              colorQAD: colorQAD, 
              textFieldAlmacen: textFieldAlmacen()),
            UbicacionTransitoArchivoControl(
              colorQAD: colorQAD, 
              textFieldUbicTransito: textFieldUbicTransito()),    
            const SizedBox(height: 20),  
            ElevatedButton(
              onPressed: () {
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

TextFormField textFieldDominio() {
  return TextFormField(
    //controller: _controllerAlmacen,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldArchivoControl(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldAlmacen() {
  return TextFormField(
    //controller: _controllerAlmacen,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldArchivoControl(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

TextFormField textFieldUbicTransito() {
  return TextFormField(
    //controller: _controllerAlmacen,
    //autocorrect: false,
    decoration: inputDecorationTextFormFieldArchivoControl(),
    /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
    //onChanged: (value) => buscarTpago(value, dbProvider),
  );
}

InputDecoration inputDecorationTextFormFieldArchivoControl() {
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
