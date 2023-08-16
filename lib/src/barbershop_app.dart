import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barber_shop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barber_shop/src/core/ui/widget/loader.dart';
import 'package:dw_barber_shop/src/features/auth/login/login_page.dart';
import 'package:dw_barber_shop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const Loader(),
        builder: (asyncNavigatorObserver) {
          return MaterialApp(
            title: 'Barber Shop',
            debugShowCheckedModeBanner: false,
            theme: BarbershopTheme.themeData,
            navigatorObservers: [asyncNavigatorObserver],
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
              '/home/adm': (_) => const Text('Adm'),
              '/auth/employee': (_) => const Text('Employee'),
            },
          );
        });
  }
}
