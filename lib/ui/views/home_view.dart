import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/domain/consultation.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:schedulerapp/ui/widgets/consultations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('${Provider.of<User>(context).name}'),
          leading: Icon(Icons.school),
        ),
        body: Consultations(),
      ),
    );
  }
}


Widget subtitle(BuildContext context, Consultation consultation) {
  var color = Colors.grey;
  double indicatorLevel = 1;

  switch (consultation.consultationType) {
    case 'Консультация':
      color = Colors.green;
      indicatorLevel = 1;
      break;
    case 'Экзамен':
      color = Colors.red;
      indicatorLevel = 1;
      break;
    case 'Жопа':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }

  return Row(children: <Widget>[
    Expanded(
      flex: 1,
      child: LinearProgressIndicator(
        backgroundColor: Theme.of(context).textTheme.title.color,
        value: indicatorLevel,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    ),
    SizedBox(width: 10),
    Expanded(
      flex: 3,
      child: Text(consultation.teacher,
          style: TextStyle(color: Theme.of(context).textTheme.title.color)),
    )
  ]);
}
