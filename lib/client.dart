import 'dart:async';

import 'package:feed_parser/domain/channel.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class FeedParser {
  http.Client client;

  FeedParser() {
    client = new http.Client();
  }

  Future<Channel> fetch(String url) {
    return client.get(url).then((response) {
      print('Response status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return response.body;
    }).then((bodyString) {
      var document = xml.parse(bodyString);
      var channel = new Channel.parse(document);
      return channel;
    });
  }
}
