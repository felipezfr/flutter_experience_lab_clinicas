import 'dart:developer';

import 'package:fe_lab_clinicas_adm/src/repositories/painel/painel_repository.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/attendent_desk_assignment/attendent_desk_assignment_repository.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';

class CallNextPatientService {
  final PatientInformationFormRepository patientInformationFormRepository;
  final AttendentDeskAssignmentRepository attendentDeskAssignmentRepository;
  final PainelRepository painelRepository;

  CallNextPatientService(
      {required this.patientInformationFormRepository,
      required this.attendentDeskAssignmentRepository,
      required this.painelRepository});

  Future<Either<RepositoryException, PatientInformationFormModel?>>
      execute() async {
    final result = await patientInformationFormRepository.callNextToCheckin();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
      PatientInformationFormModel form) async {
    final resultDesk =
        await attendentDeskAssignmentRepository.getDeskAssigment();

    switch (resultDesk) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final painelResult =
            await painelRepository.callOnPanel(form.password, deskNumber);
        switch (painelResult) {
          case Left(value: final exception):
            log('ATENCAO!!! Nao foi possivel chamar o paciente',
                error: exception,
                stackTrace: StackTrace.fromString(
                    'ATENCAO!!! Nao foi possivel chamar o paciente'));
            return Right(form);
          case Right():
            return Right(form);
        }
    }
  }
}
