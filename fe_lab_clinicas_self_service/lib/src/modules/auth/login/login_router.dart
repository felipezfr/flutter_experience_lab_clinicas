import 'package:fe_lab_clinicas_self_service_cb/src/modules/auth/login/login_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/auth/login/login_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/service/user_login_service.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/service/user_login_service_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LoginRouter extends FlutterGetItModulePageRouter {
  const LoginRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserLoginService>(
            (i) => UserLoginServiceImp(userRepository: i())),
        Bind.lazySingleton((i) => LoginController(userLoginService: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}
