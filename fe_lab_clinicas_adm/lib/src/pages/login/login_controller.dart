import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../services/login/user_login_service.dart';

class LoginController with MesssageStateMixin {
  final UserLoginService _userLoginService;

  LoginController({
    required UserLoginService userLoginService,
  }) : _userLoginService = userLoginService;

  final _obscurePassword = signal(true);
  final _logged = signal(false);

  bool get obscurePassword => _obscurePassword.value;
  bool get logged => _logged.value;

  void passwordToogle() => _obscurePassword.value = !_obscurePassword.value;

  Future<void> login(String email, String password) async {
    final loginResult =
        await _userLoginService.execute(email, password).asyncLoader();

    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        //Error
        showError(message);

      case Right(value: _):
        //Redirecionar
        _logged.value = true;
    }
  }
}
