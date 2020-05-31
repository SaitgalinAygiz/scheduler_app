
import 'package:flutter/widgets.dart';

@immutable
class Message {
  final String title;
  final String body;

  const Message(this.title, this.body);
}