import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/find_patient/find_patient_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/find_patient/find_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class FindPatientRoute extends FlutterGetItModulePageRouter {
  const FindPatientRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
            (i) => FindPatientController(patientRepository: i())),
      ];

  @override
  WidgetBuilder get view => (context) => const FindPatientPage();
}
