import 'package:get/get_connect/connect.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

class Scrapper {
  static void exampleGetLinks(Response response) {
    var document = parser.parse(response.body);

    List<Element> links = document.getElementsByTagName('a');
    List<Element>? children = document.body?.children;

    print(links[1].attributes);
    print(links[1].innerHtml);

    print(document
        .getElementsByTagName('head')
        .first
        .getElementsByTagName('title')
        .first
        .text);
    print(document.getElementsByTagName('title').first.text);

    // links.forEach((element) {
    //   if (element.attributes['href'] != null) {
    //     print(element.attributes['href']);
    //   }
    // });

    //print(document.body?.innerHtml);

    //developer.log(document.body?.innerHtml ?? 'empty', name: 'my.app.web');
  }

  static List<Element>? getChildren(Element? element) => element?.children;
  static List<Element>? getLinks(Element? element) => element
      ?.getElementsByTagName('a')
      .where((link) =>
          link.attributes['href'] != null &&
          link.attributes['href'].toString().startsWith('/'))
      .toList();

  static List<Element>? selectElement(List<Element>? elements, int index) =>
      elements != null ? <Element>[elements[index]] : <Element>[];

  static String? getHref(Element element) {}

  static String? getMetaTitle(Document document) =>
      document.getElementsByTagName('title').first.text;

  static Document getDocument(Response response) => parser.parse(response.body);
}
