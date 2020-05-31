import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:schedulerapp/services/auth.dart';

class AuthService extends ChangeNotifier {
  final AuthApi _api;
  AuthService(this._api);

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get currentUser {
    return FirebaseAuth.instance.onAuthStateChanged
        .map((FirebaseUser user) => user != null ? User.fromFirebase(user) : null);
  }

  Future<bool> login(AuthCredential authCredential) async {
    var fetchedUser = await _api.signIn(authCredential);
    var hasUser = fetchedUser != null;
    return hasUser;
  }

}