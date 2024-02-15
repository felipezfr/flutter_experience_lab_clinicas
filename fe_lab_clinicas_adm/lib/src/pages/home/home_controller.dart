import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:fe_lab_clinicas_adm/src/repositories/attendent_desk_assignment/attendent_desk_assignment_repository.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

class HomeController with MesssageStateMixin {
  final AttendentDeskAssignmentRepository _attendentDeskAssignmentRepository;

  HomeController(
      {required AttendentDeskAssignmentRepository
          attendentDeskAssignmentRepository})
      : _attendentDeskAssignmentRepository = attendentDeskAssignmentRepository;

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();

    final result =
        await _attendentDeskAssignmentRepository.startService(deskNumber);

    switch (result) {
      case Left():
        asyncstate.AsyncState.hide();

        return showError('Error ao iniciar');
      case Right():
        asyncstate.AsyncState.hide();
        showInfo('Registrou com sucesso');
    }
  }
}
