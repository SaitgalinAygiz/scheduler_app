import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:schedulerapp/domain/consultation.dart';
import 'package:schedulerapp/domain/user.dart';
import 'package:schedulerapp/ui/shared/app_colors.dart';
import 'package:schedulerapp/ui/shared/consultation_type.dart';
import 'package:schedulerapp/ui/shared/text_styles.dart';
import 'package:schedulerapp/ui/shared/ui_helper.dart';
import 'package:intl/intl.dart';

class ConsultationView extends StatelessWidget {
  final Consultation consultation;
  const ConsultationView({Key key, this.consultation}) : super (key: key);

  Widget _buildHeader(BuildContext context) => Stack(children: <Widget>[
    Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.red
      ),
    ),
    Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color.fromRGBO(58, 68, 85, .9)),
      child: Center(
        child: _buildTopContentText(),
      ),
    ),
    Container(
      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          )
        ],
      ),
    ),
  ]);

  Widget _buildTopContentText() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 60.0),
      Text(
        consultation.name,
        style: TextStyle(color: Colors.white, fontSize: 30.0),
      ),
      SizedBox(height: 20.0),
      Text(
        consultation.description,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
        maxLines: 5,
      ),
      SizedBox(height: 20.0),
      Expanded(
          child: Column(
            children: [
              ConsultationType(type: consultation.consultationType),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ))
    ],
  );

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
                _buildHeader(context),
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