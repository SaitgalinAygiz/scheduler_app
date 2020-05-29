import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:schedulerapp/services/auth.dart';

class AuthService extends ChangeNotifier {
  final AuthApi _api;
  AuthService(this._api);

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<bool> login(String id) async {
    final fetchedUser = await _api.fetchUser(id);
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

}