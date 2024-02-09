import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/widgets/lab_clinicas_self_service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'widgets/document_box_widget.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessageViewMixin {
  final selfServiceController = Injector.get<SelfServiceController>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    messageListener(selfServiceController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    final documents = selfServiceController.model.documents;

    final totaHealthInsuranceCard =
        documents?[DocumentType.healthInsuranceCard]?.length ?? 0;
    final totaMedicalOrder = documents?[DocumentType.medicalOrder]?.length ?? 0;

    return Scaffold(
      appBar: LabClinicasSelfServiceAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsetsDirectional.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LabClinicasTheme.orageColor,
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/folder.png'),
                  const SizedBox(height: 24),
                  const Text('ADICIONAR DOCUMENTOS',
                      style: LabClinicasTheme.titleSmallStyle),
                  const SizedBox(height: 32),
                  const Text(
                    'Selecione o documento que deseja adicionar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: LabClinicasTheme.blueColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: sizeOf.width * 0.8,
                    height: 241,
                    child: Row(
                      children: [
                        DocumentBoxWidget(
                          uploaded: totaHealthInsuranceCard > 0,
                          icon: Image.asset('assets/images/id_card.png'),
                          totalFiles: totaHealthInsuranceCard,
                          label: 'CARTEIRINHA',
                          onTap: () async {
                            final filePath = await Navigator.of(context)
                                .pushNamed('/self-service/documents/scan');

                            if (filePath != null && filePath != '') {
                              selfServiceController.registerDocuments(
                                  DocumentType.healthInsuranceCard,
                                  filePath.toString());

                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(width: 32),
                        DocumentBoxWidget(
                          uploaded: totaMedicalOrder > 0,
                          label: 'PEDIDO MÉDICO',
                          totalFiles: totaMedicalOrder,
                          icon: Image.asset('assets/images/document.png'),
                          onTap: () async {
                            final filePath = await Navigator.of(context)
                                .pushNamed('/self-service/documents/scan');

                            if (filePath != null && filePath != '') {
                              selfServiceController.registerDocuments(
                                  DocumentType.medicalOrder,
                                  filePath.toString());

                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible:
                        totaMedicalOrder > 0 && totaHealthInsuranceCard > 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              fixedSize: const Size.fromHeight(48),
                            ),
                            onPressed: () {
                              selfServiceController.clearDocuments();
                              setState(() {});
                            },
                            child: const Text('REMOVER TODAS'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LabClinicasTheme.orageColor,
                              fixedSize: const Size.fromHeight(48),
                            ),
                            onPressed: () async {
                              await selfServiceController.finalize();
                            },
                            child: const Text('FINALIZAR'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
