import 'package:fe_lab_clinicas_adm/src/pages/home/home_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HomeRouter extends FlutterGetItPageRouter {
  const HomeRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => HomeController(
            attendentDeskAssignmentRepository: i(),
            callNextPatientService: i())),
      ];

  @override
  String get routeName => '/home';

  @override
  WidgetBuilder get view => (context) => const HomePage();
}
