import 'package:fe_lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository_impl.dart';
import 'package:fe_lab_clinicas_adm/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../core/env.dart';
import '../repositories/attendent_desk_assignment/attendent_desk_assignment_repository.dart';
import '../repositories/attendent_desk_assignment/attendent_desk_assignment_repository_impl.dart';
import '../repositories/painel/painel_repository.dart';
import '../repositories/painel/painel_repository_impl.dart';
import '../repositories/patient_information_form/patient_information_form_repository.dart';

class LabClinicasApplicationBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton((i) => RestClient(Env.backendBaseUrl)),
        Bind.lazySingleton<PatientInformationFormRepository>(
            (i) => PatientInformationFormRepositoryImpl(restClient: i())),
        Bind.lazySingleton<AttendentDeskAssignmentRepository>(
            (i) => AttendentDeskAssignmentRepositoryImpl(restClient: i())),
        Bind.lazySingleton<PainelRepository>(
            (i) => PainelRepositoryImpl(restClient: i())),
        Bind.lazySingleton(
          (i) => CallNextPatientService(
              patientInformationFormRepository: i(),
              attendentDeskAssignmentRepository: i(),
              painelRepository: i()),
        ),
      ];
}
