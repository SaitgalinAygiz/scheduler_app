import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/provider_setup.dart';
import 'package:schedulerapp/services/push_notification_service.dart';
import 'package:schedulerapp/ui/router.dart';
import 'constants/app_constants.dart';

void main() {
  Provider.debugCheckInvalidValueType = null; //this
  runApp(SchedulerApp());
}

class SchedulerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'УКРТБ',
        theme: ThemeData(
            primaryColor: Colors.blue,
            textTheme: TextTheme(title: TextStyle(color: Colors.white))),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
