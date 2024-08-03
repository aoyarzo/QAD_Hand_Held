import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/presentation/widgets/widgets.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class ArchivoControlLoginScreen extends ConsumerWidget {
  static const name = 'archivo-control-login-screen';

  final _controllerDominio = TextEditingController();
  final _controllerUrl = TextEditingController();
  final _controllerAlmacen = TextEditingController();
  final _controllerUbicTrans = TextEditingController();

  ArchivoControlLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);
    _controllerDominio.text = Preferences.dominio;
    _controllerUrl.text = Preferences.url;
    _controllerAlmacen.text = Preferences.almacen;
    _controllerUbicTrans.text = Preferences.ubicTrans;

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
                  context.go('/login');
                },
                icon: const Icon(Icons.arrow_back_outlined,
                    size: 26, color: Colors.white)),
          )),
      //drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: UrlArchivoControl(
                  colorQAD: colorQAD,
                  textFieldUrl: textFieldUrl(_controllerUrl)),
            ),
            DominioArchivoControl(
                colorQAD: colorQAD,
                textFieldDominio: textFieldDominio(_controllerDominio)),
            AlmacenArchivoControl(
                colorQAD: colorQAD,
                textFieldAlmacen: textFieldAlmacen(_controllerAlmacen),
                iconButton: () async {
                  final descSite = await GetSiteApiDatasource().validateSite(
                      _controllerDominio.text, _controllerAlmacen.text);

                  ref.read(validateSiteProvider.notifier).state =
                      descSite.isEmpty ? false : true;
                  print(descSite);
                }),
            UbicacionTransitoArchivoControl(
                colorQAD: colorQAD,
                textFieldUbicTransito:
                    textFieldUbicTransito(_controllerUbicTrans)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Preferences.dominio = _controllerDominio.text;
                  Preferences.url = _controllerUrl.text;
                  Preferences.almacen = _controllerAlmacen.text;
                  Preferences.ubicTrans = _controllerUbicTrans.text;

                  context.go('/login');
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

TextFormField textFieldDominio(TextEditingController controllerDominio) {
  return TextFormField(
    controller: controllerDominio,
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

TextFormField textFieldUrl(TextEditingController controllerUrl) {
  return TextFormField(
    controller: controllerUrl,
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

TextFormField textFieldAlmacen(TextEditingController controllerAlmacen) {
  return TextFormField(
    controller: controllerAlmacen,
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

TextFormField textFieldUbicTransito(TextEditingController controllerUbicTrans) {
  return TextFormField(
    controller: controllerUbicTrans,
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
