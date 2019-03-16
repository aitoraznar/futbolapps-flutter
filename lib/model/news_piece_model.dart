import 'package:json_annotation/json_annotation.dart';

part 'news_piece_model.g.dart';

@JsonSerializable()
class NewsPiece extends Object{
  String id;
  String team;
  //Date createdAt;
  //Date updatedAt;
  String imagen;
  String imagenMin;
  String titulo;
  String descripcion;
  //Date fecha;
  String url;
  String fuente;
  String slug;

  NewsPiece({
    this.id, this.team, this.imagen, this.imagenMin, this.titulo, this.descripcion, this.url, this.fuente, this.slug
  });

  factory NewsPiece.fromJson(Map<String, dynamic> json) => _$NewsPieceFromJson(json);
  Map<String, dynamic> toJson() => _$NewsPieceToJson(this);

}
