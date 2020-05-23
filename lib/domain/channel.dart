import 'dart:core';

import 'package:feed_parser/util/helpers.dart';
import 'package:xml/xml.dart';

import 'image.dart';
import 'item.dart';

class Channel {
  final String title;
  final String description;
  final String link;
  final List<Item> items;

  final Image image;
  final String lastBuildDate;
  final String language;
  final String generator;
  final String copyright;

  Channel(this.title, this.description, this.link, this.items,
      {this.image,
      this.lastBuildDate,
      this.language,
      this.generator,
      this.copyright});

  factory Channel.parse(XmlDocument document) {
    XmlElement channnelElement;

    try {
      channnelElement = document.findAllElements('channel').first;
    } on StateError {
      throw new ArgumentError('channel not found');
    }
    var title = xmlGetString(channnelElement, 'title');
    var description = xmlGetString(channnelElement, 'description');
    var link = xmlGetString(channnelElement, 'link');

    var feeds =
        channnelElement.findAllElements('item').map((XmlElement element) {
      return new Item.parse(element);
    }).toList();

    Image image;

    try {
      image = new Image.parse(channnelElement.findElements('image').first);
    } on StateError {}

    var lastBuildDate =
        xmlGetString(channnelElement, 'lastBuildDate', strict: false);
    var language = xmlGetString(channnelElement, 'language', strict: false);
    var generetor = xmlGetString(channnelElement, 'generator', strict: false);
    var copyright = xmlGetString(channnelElement, 'copyright', strict: false);

    return new Channel(
      title,
      description,
      link,
      feeds,
      image: image,
      lastBuildDate: lastBuildDate,
      language: language,
      generator: generetor,
      copyright: copyright,
    );
  }

  @override
  String toString() {
    return '''
    title: $title
    description: $description
    link: $link
    lastBuildDate: $lastBuildDate
    items: $items
    ''';
  }
}
