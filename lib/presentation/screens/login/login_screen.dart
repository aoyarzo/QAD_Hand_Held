import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/infraestructure/datasources/datasource.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class LoginScreen extends ConsumerWidget {
  static const name = 'login-screen';

  final _controllerUsuario = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    Color colorQAD = const Color(0xFFe97a3b);
    Color colorQAD2 = const Color(0xFF0b2038);

    var textStyleTitulo =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: colorQAD2);

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: colorQAD,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  'QAD Hand Held',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorQAD2),
                ),

                /*const Text('¡Bienvenido!',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),   */
              ],
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: colorQAD,
                  border: Border.all(width: 0, color: colorQAD)),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  //alignment: Alignment.center,

                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: IconButton(
                              onPressed: () async {

                                final descSite = await GetSiteApiDatasource().
                                validateSite(Preferences.dominio, Preferences.almacen);

                                ref.read(validateSiteProvider.notifier).state =
                                descSite.isEmpty ? false : true;
                                
                                context.go('/archivo-control');
                              },
                              icon: Icon(
                                Icons.settings_outlined,
                                color: colorQAD,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50, top: 20),
                              child: Text('Usuario', style: textStyleTitulo),
                            ),
                            //const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextField(
                                controller: _controllerUsuario,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_outline,
                                      color: colorQAD),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: colorQAD)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: colorQAD)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50, top: 20),
                              child: Text('Contraseña', style: textStyleTitulo),
                            ),
                            //const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password_outlined,
                                    color: colorQAD,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: colorQAD)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: colorQAD)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 180,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {

                                Preferences.usuario = _controllerUsuario.text;
                                context.go('/transf-inv');
                                
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorQAD),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
