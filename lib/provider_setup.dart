import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:schedulerapp/services/auth.dart';
import 'package:schedulerapp/services/authentication_service.dart';
import 'package:schedulerapp/services/consultations_api.dart';

import 'domain/user.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: AuthApi()),
  Provider.value(value: ConsultationsApi()),
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<AuthApi, AuthService>(
    update: (BuildContext context, AuthApi authApi, AuthService authService) =>
        AuthService(authApi),
  )
];
List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<User>(
    create: (context) => Provider.of<AuthService>(context, listen: false).currentUser,
  )
];
