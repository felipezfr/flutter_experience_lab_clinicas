import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_painel/src/models/painel_checkin_model.dart';
import 'package:fe_lab_clinicas_painel/src/pages/painel/painel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'widgets/painel_principal_widgets.dart';
import 'widgets/password_tile.dart';

class PainelPage extends StatefulWidget {
  const PainelPage({super.key});

  @override
  State<PainelPage> createState() => _PainelPageState();
}

class _PainelPageState extends State<PainelPage> {
  final controller = Injector.get<PainelController>();

  @override
  void initState() {
    controller.listenerPainel();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PainelCheckinModel? current;
    final PainelCheckinModel? lastCall;
    final List<PainelCheckinModel>? others;

    final listPanel = controller.painelData.watch(context);

    current = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    lastCall = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    others = listPanel;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                lastCall != null
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width * .4,
                        child: PainelPrincipalWidgets(
                          passwordLabel: 'Senha anterior',
                          deskNumber: lastCall.attendantDesk.toString(),
                          password: lastCall.password,
                          buttonColor: LabClinicasTheme.blueColor,
                          labelColor: LabClinicasTheme.orageColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                current != null
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width * .4,
                        child: PainelPrincipalWidgets(
                          passwordLabel: 'Chamando senha',
                          deskNumber: current.attendantDesk.toString(),
                          password: current.password,
                          buttonColor: LabClinicasTheme.orageColor,
                          labelColor: LabClinicasTheme.blueColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 40),
            const Divider(
              color: LabClinicasTheme.orageColor,
            ),
            const SizedBox(height: 30),
            const Text(
              'Últimos chamados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: LabClinicasTheme.orageColor,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                runAlignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: others
                    .map((p) => PasswordTile(
                          password: p.password,
                          deskNumber: p.attendantDesk.toString(),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
