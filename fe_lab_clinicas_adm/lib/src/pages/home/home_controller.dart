import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import 'package:fe_lab_clinicas_adm/src/repositories/attendent_desk_assignment/attendent_desk_assignment_repository.dart';
import 'package:fe_lab_clinicas_adm/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomeController with MesssageStateMixin {
  final AttendentDeskAssignmentRepository _attendentDeskAssignmentRepository;
  final CallNextPatientService _callNextPatientService;

  HomeController(
      {required AttendentDeskAssignmentRepository
          attendentDeskAssignmentRepository,
      required CallNextPatientService callNextPatientService})
      : _attendentDeskAssignmentRepository = attendentDeskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  final _informationForm = signal<PatientInformationFormModel?>(null);
  PatientInformationFormModel? get informationForm => _informationForm();

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();

    final result =
        await _attendentDeskAssignmentRepository.startService(deskNumber);

    switch (result) {
      case Left():
        asyncstate.AsyncState.hide();

        return showError('Error ao iniciar');
      case Right():
        final resultNextPatient = await _callNextPatientService.execute();
        switch (resultNextPatient) {
          case Left():
            showError('Erro ao chamar o proximo paciente');
          case Right(value: final form?):
            asyncstate.AsyncState.hide();
            _informationForm.value = form;
          case Right(value: _):
            asyncstate.AsyncState.hide();
            showInfo('Nenhum paciente aguardando');
        }
    }
  }
}
