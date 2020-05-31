import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schedulerapp/constants/app_constants.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:http/http.dart' as http;

class AuthApi {

  setAuthToken(String authToken, String username) async {
    var url = 'https://ukrtb-remote.herokuapp.com/student/setAuthToken';

    Map data = {
      "name": username,
      "authToken": authToken
    };

    await http.post(url, body: data);
  }

  signIn(AuthCredential authCredential) async {
    AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(authCredential);
    FirebaseUser firebaseUser = authResult.user;
    return User.fromFirebase(firebaseUser);
  }

  Future<User> fetchUser(String id) async {
    var url = 'https://ukrtb-remote.herokuapp.com/student/findByPhoneNumber';
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
      var teacherUrl = 'https://ukrtb-remote.herokuapp.com/teacher/findByPhoneNumber';
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