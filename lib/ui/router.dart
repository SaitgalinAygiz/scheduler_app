import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schedulerapp/constants/app_constants.dart';
import 'package:schedulerapp/domain/consultation.dart';
import 'package:schedulerapp/ui/views/auth.dart';
import 'package:schedulerapp/ui/views/consultation_view.dart';
import 'package:schedulerapp/ui/views/home_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => AuthorizationPage());
      case RoutePaths.Consultation:
        var consultation = settings.arguments as Consultation;
        return MaterialPageRoute(builder: (_) => ConsultationView(consultation: consultation,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('Неизвестный роут ${settings.name}'),
              ),
            ));

    }
  }
}