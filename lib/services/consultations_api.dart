import 'dart:convert';

import 'package:schedulerapp/domain/consultation.dart';
import 'package:http/http.dart' as http;

class ConsultationsApi {


  Future<List<Consultation>> fetchConsultations(String userName) async {

    Map body = {
      'name': userName
    };
    var url = 'https://ukrtb-remote.herokuapp.com/consultation/findByName';

    final response = await http.post(url, body: body);

    List responseJson = json.decode(response.body);
    var consultations = responseJson.map((m) => new Consultation.fromJson(m)).toList();
    consultations.sort((Consultation a, Consultation b) => a.time.compareTo(b.time));
    return consultations;
  }
}