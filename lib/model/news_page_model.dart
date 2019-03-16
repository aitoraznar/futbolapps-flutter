import 'package:json_annotation/json_annotation.dart';
import 'news_piece_model.dart';

part 'news_page_model.g.dart';

@JsonSerializable()
class NewsPage extends Object{
  List<NewsPiece> newsPieces;

  NewsPage({
    this.newsPieces
  });

  factory NewsPage.fromJson(List<dynamic> json) => _$NewsPageFromJson(json);
  Map<String, dynamic> toJson() => _$NewsPageToJson(this);

}
