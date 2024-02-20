import 'dart:async';
import 'dart:developer';

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'package:fe_lab_clinicas_painel/src/pages/splash/splash_page.dart';

import 'src/binding/lab_clinicas_application_binding.dart';
import 'src/pages/login/login_router.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const LabClinicasPainelApp());
  }, (error, stack) {
    log('Erro nao tratado', error: error, stackTrace: stack);
    throw error;
  });
}

class LabClinicasPainelApp extends StatelessWidget {
  const LabClinicasPainelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clinicas Painel',
      bindings: LabClinicasApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
            page: (context) => const SplashPage(), path: '/'),
      ],
      pages: const [
        LoginRouter(),
        // HomeRouter(),
        // PreCheckinRouter(),
        // CheckinRouter(),
        // EndCheckinRouter(),
      ],
    );
  }
}
