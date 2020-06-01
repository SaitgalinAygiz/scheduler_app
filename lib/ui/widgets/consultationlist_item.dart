import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedulerapp/domain/consultation.dart';
import 'package:schedulerapp/ui/shared/consultation_type.dart';

class ConsultationListItem extends StatelessWidget {
  final Consultation consultation;
  final Function onTap;
  const ConsultationListItem({this.consultation, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
        padding: EdgeInsets.all(11.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: getColor(consultation.consultationType)),
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
            Padding(padding: EdgeInsets.only(top: 5),),
            Text("через " + getDayR(consultation.time).toString() + " " + mm(getDayR(consultation.time)), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

mm(int i) {
  switch (i) {
    case 1: return "день";
    case 2: return "дня";
    case 3: return "дня";
    case 4: return "дня";
    default: return "дней";
  }
}

getDayR(DateTime time) {
  return DateTime.now().difference(time).inDays * -1;
}

getColor(String consultationType) {
  switch (consultationType) {
    case 'Экзамен':
      return Colors.red;
      break;
    case 'Консультация':
      return Colors.green;
      break;
    default:
      return Colors.deepPurpleAccent;
  }
}