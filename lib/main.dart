import 'package:feed_parser/client.dart';

void main() {
  var client = new FeedParser();
  client.fetch("https://developer.apple.com/news/releases/rss/releases.rss");
}
