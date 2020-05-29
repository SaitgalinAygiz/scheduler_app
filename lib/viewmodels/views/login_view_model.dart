import 'package:flutter/cupertino.dart';
import 'package:schedulerapp/services/authentication_service.dart';
import 'package:schedulerapp/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthService _authService;

  LoginViewModel({
    @required AuthService authService,
  }) : _authService = authService;


  Future<bool> login(String userId) async {
    setBusy(true);
    var success = await _authService.login(userId);
    setBusy(false);
    return success;
  }

}