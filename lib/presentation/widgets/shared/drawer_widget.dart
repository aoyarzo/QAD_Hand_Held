import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/providers/providers.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

class DrawerMenuWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color colorQAD = const Color(0xFFe97a3b);

    return Drawer(
      child: Container(
        color: const Color(0xFFE5E7EC),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                margin: const EdgeInsets.only(bottom: 0),
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E7EC),
                ),
                child: Column(
                  //ScrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person_pin_rounded, color: colorQAD),
                        const SizedBox(width: 10),
                        Text(
                          'Usuario: ',
                          style: TextStyle(fontSize: 15, color: colorQAD),
                          maxLines: 1,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          Preferences.nombre,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, color: colorQAD),
                        const SizedBox(width: 10),
                        Text(
                          'Dominio:',
                          style: TextStyle(fontSize: 15, color: colorQAD),
                          maxLines: 1,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          Preferences.dominio,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                ref.read(validateDetOCProvider.notifier).state = false;
                ref.read(validateOrdenProvider.notifier).state = false;
                context.go('/recepcion-oc');
              },
              title: const Text('Recepción OC', style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.receipt_long_outlined,
                color: colorQAD,
              ),
            ),
            ListTile(
              onTap: () {
                ref.read(validatePartProvider.notifier).state = false;
                ref.read(validateLocProvider.notifier).state = false;
                context.go('/transf-inv');
              },
              title: const Text('Transf. Inventario',
                  style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.file_open_outlined,
                color: colorQAD,
              ),
            ),
            ListTile(
              onTap: () {
                ref.read(validateLocAjusteInvProvider.notifier).state = false;
                ref.read(validateArtAjusteInvProvider.notifier).state = false;
                context.go('/ajuste-inv');
              },
              title: const Text('Ajuste Inventario',
                  style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.payments_outlined,
                color: colorQAD,
              ),
            ),
            ListTile(
              onTap: () {
                ref.read(validateLocAjusteInvProvider.notifier).state = false;
                ref.read(validateArtAjusteInvProvider.notifier).state = false;
                context.go('/entrada-salida');
              },
              title: const Text('Entrada/Salida No Planif.',
                  style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.playlist_add_check_outlined,
                color: colorQAD,
              ),
            ),
            ListTile(
              onTap: () {
                context.go('/consulta');
              },
              title: const Text('Consultas de Stock',
                  style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.list_alt_outlined,
                color: colorQAD,
              ),
            ),
            /* ListTile(
              onTap: () {
                context.go('/archivo-control');
              },
              title:
                  const Text('Archivo Control', style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.settings_applications,
                color: colorQAD,
              ),
            ),*/
            ListTile(
              onTap: () {
                Preferences.inicio = 'logout';
                context.go('/login');
              },
              title:
                  const Text('Cerrar Sesión', style: TextStyle(fontSize: 14)),
              leading: Icon(
                Icons.logout_rounded,
                color: colorQAD,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
