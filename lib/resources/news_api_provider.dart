import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:core';

import 'package:json_data/models/item_model.dart';

final String root = "https://law-chamber-api.ocody.com/admin";

class NewsApiProvider {
  Client client = Client();

  featchCounts(String authToken, String addApi) async {
    String uri = root + addApi;
    final resp = await client.get(
      uri,
      headers: {
        'Authorization': authToken,
        'X-Requested-With': 'XMLHttpRequest',
      },
    );
    final counts = json.decode(resp.body);
    //CountModel count=CountModel.fromJson(counts);
    return counts;

  // featchItems(String authToken) async {
  //   final resp = await client.get(root, headers: {
  //     'Authorization': authToken,
  //     'X-Requested-With': 'XMLHttpRequest',
  //   });
  //   final parshedJson = json.decode(resp.body);
  //   return CountModel.fromJson(parshedJson);
  // }
}
}