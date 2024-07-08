import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/login', 
  routes: [
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
      ),
      
    GoRoute(
      path: '/transf-inv',
      name: TransferenciaInventarioScreen.name,
      builder: (context, state) => const TransferenciaInventarioScreen(),
      ),

    GoRoute(
      path: '/trans-origen',
      name: TransferenciaOrigenScreen.name,
      builder: (context, state) => TransferenciaOrigenScreen(),
      ),

    /*GoRoute(
      path: '/trans-destino',
      name: TransferenciaDestinoScreen.name,
      builder: (context, state) => TransferenciaDestinoScreen(),
      ),  */

    GoRoute(
      path: '/archivo-control',
      name: ArchivoControlScreen.name,
      builder: (context, state) => ArchivoControlScreen(),
      ),
    
    GoRoute(
      path: '/archivo-control-login',
      name: ArchivoControlLoginScreen.name,
      builder: (context, state) => ArchivoControlLoginScreen(),
      ),         
      
      ]
      );
