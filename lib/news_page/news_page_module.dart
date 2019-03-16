import 'dart:async' show Future;
import 'dart:async';
import '../model/news_page_model.dart';
import 'api.dart';

class NewsPageModule {
  Api api;
  String teamName;
  static const int initialPage = 1;
  int currentPage = initialPage;
  int pageSize = 5;

  NewsPageModule(config, teamName) {
    this.teamName = teamName;
    this.pageSize = config.modules['newsPageModule']['pageSize'];
    this.api = new Api(config);
  }

  Future<NewsPage> getInitialPage() => this.api.getNewsPage(teamName, currentPage, pageSize);
  Future<NewsPage> getNextPage() => this.api.getNewsPage(teamName, ++currentPage, pageSize);
  Future<NewsPage> getPreviousPage() => this.api.getNewsPage(teamName, --currentPage, pageSize);
}

