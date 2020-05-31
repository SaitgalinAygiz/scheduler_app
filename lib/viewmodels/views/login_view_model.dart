import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedulerapp/services/authentication_service.dart';
import 'package:schedulerapp/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthService _authService;

  LoginViewModel({
    @required AuthService authService,
  }) : _authService = authService;


  Future<bool> login(AuthCredential authCredential) async {
    setBusy(true);
    var success = await _authService.login(authCredential);
    setBusy(false);
    return success;
  }

}