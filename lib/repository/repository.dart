import 'package:json_data/resources/news_api_provider.dart';

import '../models/item_model.dart';

class Repository {
  NewsApiProvider newsApiProvider = NewsApiProvider();

  Future featchCounts(String authToken, String addApi) async {
    final resp = await newsApiProvider.featchCounts(authToken, addApi);
    return resp;
  }
}
