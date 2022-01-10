import 'dart:convert';

class ScrappedElement {
  final String tag;
  final String attributes;

  ScrappedElement(this.tag, this.attributes);

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
      'attributes': attributes,
    };
  }

  factory ScrappedElement.fromMap(Map<String, dynamic> map) {
    return ScrappedElement(
      map['tag'] ?? '',
      map['attributes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ScrappedElement.fromJson(String source) =>
      ScrappedElement.fromMap(json.decode(source));

  @override
  String toString() => 'ScrappedElement(tag: $tag, attributes: $attributes)';
}
