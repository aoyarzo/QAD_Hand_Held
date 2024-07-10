import 'package:go_router/go_router.dart';
import 'package:qad_hand_held/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/login', 
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

    /*GoRoute(
      path: '/trans-destino',
      name: TransferenciaDestinoScreen.name,
      builder: (context, state) => TransferenciaDestinoScreen(),
      ),  */
   
    GoRoute(
      path: '/archivo-control',
      name: ArchivoControlLoginScreen.name,
      builder: (context, state) => ArchivoControlLoginScreen(),
      ),         
      
      ]
      );
