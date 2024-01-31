import 'package:fe_lab_clinicas_self_service_cb/src/modules/auth/login/login_router.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/user/user_repository.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/user/user_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserRepository>(
            (i) => UserRepositoryImp(restClient: i())),
      ];

  @override
  String get moduleRouteName => '/auth';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/login': (_) => const LoginRouter(),
      };
}
