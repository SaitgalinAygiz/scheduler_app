import 'package:flutter/cupertino.dart';
import 'package:schedulerapp/domain/consultation.dart';
import 'package:schedulerapp/services/consultations_api.dart';
import 'package:schedulerapp/viewmodels/base_model.dart';

class ConsultationModel extends BaseModel {
  ConsultationsApi _api;

  ConsultationModel({
    @required ConsultationsApi api,
  }) : _api = api;

  List<Consultation> consultations;

  Future getConsultations(String userName) async {
    setBusy(true);
    consultations = await _api.fetchConsultations(userName);
    setBusy(false);
  }

}