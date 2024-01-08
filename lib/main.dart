import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/firebase_options.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/themes/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  setUplocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: Ngbuka()));
}

class Ngbuka extends StatelessWidget {
  static final _router = locator<GoRouter>();
  const Ngbuka({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: FlutterSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Ngbuka',
            theme: AppTheme.defaultTheme,
            // theme: ThemeData(useMaterial3: false),
            routerConfig: _router,
          );
        },
      ),
    );
  } 
}
