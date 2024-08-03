import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:qad_hand_held/config/router/app_router.dart';
import 'package:qad_hand_held/config/theme/app_theme.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const ProviderScope(child: MyApp()));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
           GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
              Locale('en', ''),
              Locale('es', ''),
            ],      
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
