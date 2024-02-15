import 'package:fe_lab_clinicas_adm/src/pages/home/home_controller.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final deskNumberEC = TextEditingController();
  final controller = Injector.get<HomeController>();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  void dispose() {
    deskNumberEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(40),
            width: sizeOf.width * .4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orageColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Bem Vindo!', style: LabClinicasTheme.titleStyle),
                const SizedBox(height: 32),
                const Text(
                  'Preencha o número do guichê que você está atendendo',
                  style: LabClinicasTheme.subTitleSmallStyle,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: sizeOf.width * .4,
                  child: TextFormField(
                    controller: deskNumberEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Guichê obrigatório'),
                      Validatorless.number('Guichê deve ser um número'),
                    ]),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      label: Text('Número do guichê'),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: sizeOf.width * .4,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      final valid = formKey.currentState?.validate() ?? false;

                      if (valid) {
                        controller.startService(int.parse(deskNumberEC.text));
                      }
                    },
                    child: const Text('CHAMAR PRÓXIMO PACIENTE'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
