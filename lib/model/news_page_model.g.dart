// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPage _$NewsPageFromJson(List<dynamic> json) {
  return NewsPage(
      newsPieces: json
          ?.map((e) =>
              e == null ? null : NewsPiece.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NewsPageToJson(NewsPage instance) =>
    <String, dynamic>{'newsPieces': instance.newsPieces};
