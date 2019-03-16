// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_piece_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPiece _$NewsPieceFromJson(Map<String, dynamic> json) {
  return NewsPiece(
      id: json['id'] as String,
      team: json['team'] as String,
      imagen: json['imagen'] as String,
      imagenMin: json['imagenMin'] as String,
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      url: json['url'] as String,
      fuente: json['fuente'] as String,
      slug: json['slug'] as String);
}

Map<String, dynamic> _$NewsPieceToJson(NewsPiece instance) => <String, dynamic>{
      'id': instance.id,
      'team': instance.team,
      'imagen': instance.imagen,
      'imagenMin': instance.imagenMin,
      'titulo': instance.titulo,
      'descripcion': instance.descripcion,
      'url': instance.url,
      'fuente': instance.fuente,
      'slug': instance.slug
    };
