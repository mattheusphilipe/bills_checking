import 'package:bills_checking/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:bills_checking/modules/insert_boleto/insert_boleto_page.dart';
import 'package:bills_checking/modules/login/login_page.dart';
import 'package:bills_checking/modules/splash/slash_page.dart';
import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  // travar para não ficar virando telas
  // você mesmo vira as telas qeu precisam ser viradas
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.primary,
      ),
      //home: HomePage();
      // abaixo rotas nomeadas
      initialRoute: "/splash",
      routes: {
        "/splash":  (context) => const SplashPage(),
        "/home":  (context) => const HomePage(),
        "/login":  (context) => const LoginPage(),
        "/barcode_scanner":  (context) => const BarcodeScannerPage(),
        "/insert_boleto":  (context) => const InsertBoletoPage(),
      },
    );
  }
}