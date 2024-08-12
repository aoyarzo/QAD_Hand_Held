import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/screens/screens.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

final appRouter = GoRouter(
  initialLocation: Preferences.inicio == 'login' ? '/transf-inv' : '/login', 
  routes: [
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => LoginScreen(),
      ),
      
    GoRoute(
      path: '/transf-inv',
      name: TransferenciaInventarioScreen.name,
      builder: (context, state) => TransferenciaInventarioScreen(),
      ),

    GoRoute(
      path: '/trans-origen',
      name: TransferenciaOrigenScreen.name,
      builder: (context, state) => TransferenciaOrigenScreen(),
      ),
   
    GoRoute(
      path: '/archivo-control',
      name: ArchivoControlLoginScreen.name,
      builder: (context, state) => ArchivoControlLoginScreen(),
      ),

    GoRoute(
      path: '/recepcion-oc',
      name: RecepcionOCScreen.name,
      builder: (context, state) => RecepcionOCScreen(),
      ),

    GoRoute(
      path: '/ingreso-arts',
      name: IngresoArticulosScreen.name,
      builder: (context, state) => IngresoArticulosScreen(),
      ),

    GoRoute(
      path: '/ajuste-inv',
      name: AjusteInventarioScreen.name,
      builder: (context, state) => AjusteInventarioScreen(),
      ),

    GoRoute(
      path: '/entrada-salida',
      name: EntradaSalidaScreen.name,
      builder: (context, state) => EntradaSalidaScreen(),
      ),

    GoRoute(
      path: '/consulta',
      name: ConsultaScreen.name,
      builder: (context, state) => ConsultaScreen(),
      ),                        
      
      ]
    );
