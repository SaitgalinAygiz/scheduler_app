import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedulerapp/domain/consultation.dart';

class ConsultationListItem extends StatelessWidget {
  final Consultation consultation;
  final Function onTap;
  const ConsultationListItem({this.consultation, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(consultation.name, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),),
            Text(consultation.description, maxLines: 2, overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }
}