import 'package:flutter/material.dart';

class ConsultationType extends StatelessWidget {
  final String type;
  const ConsultationType({Key key, @required this.type}) : super(key: key);

  Widget getType(BuildContext context, String type) {
    var color = Colors.grey;
    double indicatorLevel = 1;

    switch (type) {
      case 'Экзамен':
        color = Colors.red;
        indicatorLevel = 1;
        break;
      case 'Консультация':
        color = Colors.green;
        indicatorLevel = 1;
        break;
      case 'Чето-другое':
        color = Colors.red;
        indicatorLevel = 1;
        break;
    }

    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: CircleAvatar(
                backgroundColor: color,
              radius: 6,
            )
        ),
        SizedBox(width: 10),
        Expanded(
            flex: 3,
            child: Text(type,
                style: TextStyle(color: Theme.of(context).textTheme.headline6.color)))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getType(context, type),
    );
  }
}