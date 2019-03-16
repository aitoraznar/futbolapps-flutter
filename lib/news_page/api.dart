import 'package:futbolapps/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'dart:async';
import 'dart:convert';
import '../model/news_page_model.dart';

class Api {
  AppConfig config;

  Api(AppConfig config) {
    this.config = config;
  }

  Future<NewsPage> getNewsPage(team, page, pageSize) async {
    final String url = this.config.apiBaseUrl + this.config.api['news']['basePath'];
    final response = await http.get('$url/$team/$page/$pageSize');
    return NewsPage.fromJson(json.decode(response.body));
  }
}
