import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/domain/consultation.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:schedulerapp/ui/shared/app_colors.dart';
import 'package:schedulerapp/ui/shared/text_styles.dart';
import 'package:schedulerapp/ui/shared/ui_helper.dart';
import 'package:intl/intl.dart';

class ConsultationView extends StatelessWidget {
  final Consultation consultation;
  const ConsultationView({Key key, this.consultation}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('${Provider.of<User>(context).name}'),
          leading: Icon(Icons.school),
        ),
        body: Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpaceMedium,
                Text(consultation.name, style: headerStyle,),
                UIHelper.verticalSpaceLarge,

                Text(
                  'Преподаватель: ${Provider.of<User>(context).name}',
                  style: TextStyle(fontSize: 15.0),
                ),
                UIHelper.verticalSpaceMedium,
                Text("Описание: " + consultation.description),
                UIHelper.verticalSpaceMedium,
                Text("Студенты: " + consultation.students.toString()),
                UIHelper.verticalSpaceMedium,
                Text("Время: " + DateFormat('yyyy-MM-dd – kk:mm').format(consultation.time))
              ],
            ),
          ),
        ),
      ),
    );

  }}