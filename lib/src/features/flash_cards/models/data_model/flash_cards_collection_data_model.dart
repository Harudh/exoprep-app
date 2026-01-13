// To parse this JSON data, domain
//
//     final flashCardsClassDataModel = flashCardsClassDataModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'flash_cards_collection_data_model.g.dart';

String flashCardsClassDataModelToJson(FlashCardsCollectionDataModel data) => json.encode(data.toJson());

@JsonSerializable()
class FlashCardsCollectionDataModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "tag")
  final String? tag;
  @JsonKey(name: "color")
  final int? color;
  @JsonKey(name: "card_count")
  final int? cardCount;
  @JsonKey(name: "deck_ids")
  final List<String>? deckIds;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "deleted_at")
  final String? deletedAt;

  FlashCardsCollectionDataModel({
    this.id,
    this.title,
    this.tag,
    this.color,
    this.cardCount,
    this.deckIds,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory FlashCardsCollectionDataModel.fromJson(Map<String, dynamic> json) => _$FlashCardsCollectionDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardsCollectionDataModelToJson(this);
}
