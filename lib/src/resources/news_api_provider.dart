import 'package:flutter_news/src/models/item_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'repository.dart';
final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json?print=pretty');
    final ids = json.decode(response.body);

    return ids.cast<int>();//Casting is used here
  }

 Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json?print=pretty');
    final parsedJson = json.decode(response.body);
    //  print('The Response ${response.body}');
    return ItemModel.fromJason(parsedJson);
  }
}
