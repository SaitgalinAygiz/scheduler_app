import 'dart:convert';

import 'package:schedulerapp/domain/user.dart';
import 'package:http/http.dart' as http;

class AuthApi {

  Future<User> fetchUser(String id) async {
    var url = 'https://ukrtb-remote.herokuapp.com/student/findById';
    Map data = {
      'id': id
    };

    final responseFromStudentRequest = await http.post(
        url,
        body: data
    );

    //TODO: Пишу диплом, не бейте...
    if (responseFromStudentRequest.statusCode == 201 && responseFromStudentRequest.contentLength != 0) {
      return User.fromJson(json.decode(responseFromStudentRequest.body));
    } else {
      var teacherUrl = 'https://ukrtb-remote.herokuapp.com/teacher/findById';
      final responseFromTeacherRequest = await http.post(
          teacherUrl,
          body: data
      );

      if (responseFromTeacherRequest.statusCode == 201 && responseFromTeacherRequest.contentLength != 0) {
        return User.fromJson(json.decode(responseFromTeacherRequest.body));
      } else {
        return null;
      }
    }
  }
}