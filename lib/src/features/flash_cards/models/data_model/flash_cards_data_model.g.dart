// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_cards_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashCardDataModel _$FlashCardDataModelFromJson(Map<String, dynamic> json) =>
    FlashCardDataModel(
      id: json['id'] as String?,
      deckId: json['deck_id'] as String?,
      questionText: json['question_text'] as String?,
      answerText: json['answer_text'] as String?,
      questionImages: (json['question_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      answerImages: (json['answer_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orderIndex: (json['order_index'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$FlashCardDataModelToJson(FlashCardDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deck_id': instance.deckId,
      'question_text': instance.questionText,
      'answer_text': instance.answerText,
      'question_images': instance.questionImages,
      'answer_images': instance.answerImages,
      'order_index': instance.orderIndex,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
