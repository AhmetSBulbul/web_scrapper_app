import 'package:html/dom.dart';

class ActionModel {
  final Element? input;
  final List<Element> output;
  final String title;

  ActionModel({this.input, required this.output, required this.title});
}
