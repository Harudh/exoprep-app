// flash_card_data_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'flash_cards_data_model.g.dart';

String flashCardDataModelToJson(FlashCardDataModel data) => json.encode(data.toJson());

@JsonSerializable()
class FlashCardDataModel {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "deck_id")
  final String? deckId;

  @JsonKey(name: "question_text")
  final String? questionText;

  @JsonKey(name: "answer_text")
  final String? answerText;

  @JsonKey(name: "question_images")
  final List<String>? questionImages; // Store image paths/URLs

  @JsonKey(name: "answer_images")
  final List<String>? answerImages; // Store image paths/URLs

  @JsonKey(name: "order_index")
  final int? orderIndex; // For maintaining card order

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  @JsonKey(name: "deleted_at")
  final String? deletedAt;

  FlashCardDataModel({
    this.id,
    this.deckId,
    this.questionText,
    this.answerText,
    this.questionImages,
    this.answerImages,
    this.orderIndex,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory FlashCardDataModel.fromJson(Map<String, dynamic> json) => _$FlashCardDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardDataModelToJson(this);
}
