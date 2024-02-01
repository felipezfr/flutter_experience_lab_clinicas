import 'package:flutter/material.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/model/patient_model.dart';

final class SelfServiceModel {
  final String? name;
  final String? lastName;
  final PatientModel? patient;

  SelfServiceModel({this.name, this.lastName, this.patient});

  SelfServiceModel clear() {
    return copyWith(
        name: () => null, lastName: () => null, patient: () => null);
  }

  SelfServiceModel copyWith({
    ValueGetter<String?>? name,
    ValueGetter<String?>? lastName,
    ValueGetter<PatientModel?>? patient,
  }) {
    return SelfServiceModel(
      name: name != null ? name() : this.name,
      lastName: lastName != null ? lastName() : this.lastName,
      patient: patient != null ? patient() : this.patient,
    );
  }
}
