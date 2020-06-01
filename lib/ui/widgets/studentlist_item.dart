import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentListItem extends StatelessWidget {

  final String student;

  const StudentListItem({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        padding: EdgeInsets.all(11.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(student, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),),
          ],
        ),
      ),
    );
  }

}