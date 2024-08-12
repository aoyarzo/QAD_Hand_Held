import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class ConsultaScreen extends ConsumerWidget {
  static const name = 'consulta-screen';
  static const values = <String>['Disponible', 'Todos', 'Ceros'];
  ConsultaScreen({super.key});

  final _controllerArticulo = TextEditingController();
  final _controllerUbicacion = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    var textStyleTituto = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
    var textStyleDato = const TextStyle(color: Colors.black87, fontSize: 12);

    //final validateArt = ref.watch(validateDetOCProvider);
    final selectedValue = ref.watch(selectedValueConsultaProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: colorQAD,
            title: const Text('Consultas de Stock',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )),
      drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      //height: 25,
                      child: Text('Almacén:', style: textStyleTituto)),
                  const SizedBox(width: 2),
                  Container(
                      alignment: Alignment.center,
                      //height: 25,
                      child: Text(Preferences.almacen, style: textStyleDato)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 200,
              height: 180,
              //color: Colors.blue,
              child: Column(
                children: ConsultaScreen.values.map(
                  (value) {
                    return SizedBox(
                      //width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.15,
                      //color: Colors.green,
                      child: RadioListTile<String>(
                        value: value,
                        groupValue: selectedValue,
                        title: Text(value,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        onChanged: (value) => {
                          ref
                              .read(selectedValueConsultaProvider.notifier)
                              .state = value!,
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(height: 10),
            ArticuloConsultaRow(
                colorQAD: colorQAD,
                textFieldArticulo:
                    textFieldArticuloConsulta(_controllerArticulo)),
            const SizedBox(height: 10),
            UbicacionConsulta(
                colorQAD: colorQAD,
                textFieldUbicacion:
                    textFieldUbicacionConsulta(_controllerUbicacion)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  final consulta = await ConsultaApiDatasource().consuInv(
                      Preferences.dominio,
                      _controllerArticulo.text,
                      Preferences.almacen,
                      selectedValue[0],
                      _controllerUbicacion.text);
                  for (int i = 0; i < consulta.length; i++) {
                    ref
                        .read(responseConsultaChangeNotifierProvider.notifier)
                        .addConsulta(
                            consulta[i].dominio,
                            consulta[i].articulo,
                            consulta[i].almacen,
                            consulta[i].ubicacion,
                            consulta[i].loteSerie,
                            consulta[i].referencia,
                            consulta[i].cantInv,
                            consulta[i].cantAsig,
                            consulta[i].cantDisp);
                  }

                  await _showDialogConsultar(
                      context, textStyleTituto, colorQAD, ref);
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorQAD),
                child: const Text(
                  'Consultar',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
            const SizedBox(height: 10),
            //ConsultaResponseRow(colorQAD: colorQAD),
          ],
        ),
      ),
    );
  }
}

TextFormField textFieldArticuloConsulta(
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

TextFormField textFieldUbicacionConsulta(
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

Future<String?> _showDialogConsultar(BuildContext context,
    TextStyle textStyleTituto, Color colorQAD, WidgetRef ref) async {
  final consulta = ref.watch(responseConsultaChangeNotifierProvider).consulta;

  return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.zero,
            title: Center(
                child: Column(
              children: [
                const Text('Consulta Stock',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Artículo: ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    Text(consulta.first.articulo,
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            )),
            content: SingleChildScrollView(
              child: SizedBox(
                height: 360,
                width: 100,
                child: Column(
                  children: [
                    SizedBox(
                        //color: Colors.blue,
                        height: 290,
                        child: listaStocks(ref)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          ref
                              .read(responseConsultaChangeNotifierProvider
                                  .notifier)
                              .clearConsulta();
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
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

ListView listaStocks(WidgetRef ref) {
  //tarjas_temp = dbProvider.tarjas;
  //buscarEmpleado('', dbProvider);
  //final transfList = transf.transf;
  final consulta = ref.watch(responseConsultaChangeNotifierProvider).consulta;

  return ListView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: consulta.length,
      //separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        var textStyleTituto = const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600);
        var textStyleDato =
            const TextStyle(color: Colors.black87, fontSize: 12);

        return Container(
          //color: Colors.blue,
          padding: const EdgeInsets.all(5),
          //margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: const Color(0xFFDFFBCB),
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
                          //height: 20,
                          //width: 100,
                          child: Text('Ubicación:', style: textStyleTituto)),
                      const SizedBox(width: 5),
                      Container(
                          //color: Colors.red,
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 100,
                          child: Text(consulta[index].ubicacion,
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
                          child: Text(consulta[index].referencia,
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
                          child: Text('LoteSerie:', style: textStyleTituto)),
                      const SizedBox(width: 5),
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 80,
                          child: Text(consulta[index].loteSerie,
                              style: textStyleDato)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 100,
                          child: Text('Cant. Inv:', style: textStyleTituto)),
                      const SizedBox(width: 5),
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 80,
                          child: Text(consulta[index].cantInv.toString(),
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
                          child: Text('Cant. Asig:', style: textStyleTituto)),
                      const SizedBox(width: 5),
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 80,
                          child: Text(consulta[index].cantAsig.toString(),
                              style: textStyleDato)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 100,
                          child: Text('Cant. Disp:', style: textStyleTituto)),
                      const SizedBox(width: 5),
                      Container(
                          alignment: Alignment.center,
                          //height: 20,
                          //width: 80,
                          child: Text(consulta[index].cantDisp.toString(),
                              style: textStyleDato)),
                    ],
                  ),
                ],
              ),
              //const SizedBox(height: 10),
            ],
          ),
        );
      });
}

Future<void> _mensajeResponse(
    BuildContext context, Color colorQAD, WidgetRef ref) {
  final respuesta = ref.watch(responseRecepcionChangeNotifierProvider);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(Icons.warning_rounded, size: 35, color: colorQAD),
        content: SizedBox(
          width: 80,
          height: 220,
          child: Column(
            children: [
              respuesta.respuesta[0].number == '302'
                  ? const Text('¡Registros No Enviados!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center)
                  : const Text('¡Registros Enviados Exitosamente!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: respuesta.respuesta.length,
                  itemBuilder: (context, index) {
                    return Text(
                      respuesta.respuesta[index].mensaje,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    context.go('/recepcion-oc');
                    ref.read(responseRecepcionChangeNotifierProvider.notifier).clearRecepcion();
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
