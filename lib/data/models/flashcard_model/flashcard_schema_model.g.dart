// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_schema_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashcardSchemaModelCollection on Isar {
  IsarCollection<FlashcardSchemaModel> get flashcardSchemaModels =>
      this.collection();
}

const FlashcardSchemaModelSchema = CollectionSchema(
  name: r'FlashcardSchemaModel',
  id: -6024879767034178609,
  properties: {
    r'answer': PropertySchema(id: 0, name: r'answer', type: IsarType.string),
    r'confidenceScore': PropertySchema(
      id: 1,
      name: r'confidenceScore',
      type: IsarType.double,
    ),
    r'content': PropertySchema(id: 2, name: r'content', type: IsarType.string),
    r'correctOptionIndex': PropertySchema(
      id: 3,
      name: r'correctOptionIndex',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isBookmarked': PropertySchema(
      id: 5,
      name: r'isBookmarked',
      type: IsarType.bool,
    ),
    r'isCompleted': PropertySchema(
      id: 6,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'lastReviewedAt': PropertySchema(
      id: 7,
      name: r'lastReviewedAt',
      type: IsarType.dateTime,
    ),
    r'options': PropertySchema(
      id: 8,
      name: r'options',
      type: IsarType.stringList,
    ),
    r'reviewCount': PropertySchema(
      id: 9,
      name: r'reviewCount',
      type: IsarType.long,
    ),
    r'source': PropertySchema(
      id: 10,
      name: r'source',
      type: IsarType.string,
      enumMap: _FlashcardSchemaModelsourceEnumValueMap,
    ),
    r'sourceFileName': PropertySchema(
      id: 11,
      name: r'sourceFileName',
      type: IsarType.string,
    ),
    r'subtitle': PropertySchema(
      id: 12,
      name: r'subtitle',
      type: IsarType.string,
    ),
    r'tagColor': PropertySchema(id: 13, name: r'tagColor', type: IsarType.long),
    r'tags': PropertySchema(id: 14, name: r'tags', type: IsarType.string),
    r'title': PropertySchema(id: 15, name: r'title', type: IsarType.string),
    r'type': PropertySchema(
      id: 16,
      name: r'type',
      type: IsarType.string,
      enumMap: _FlashcardSchemaModeltypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 17,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _flashcardSchemaModelEstimateSize,
  serialize: _flashcardSchemaModelSerialize,
  deserialize: _flashcardSchemaModelDeserialize,
  deserializeProp: _flashcardSchemaModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _flashcardSchemaModelGetId,
  getLinks: _flashcardSchemaModelGetLinks,
  attach: _flashcardSchemaModelAttach,
  version: '3.3.0-dev.3',
);

int _flashcardSchemaModelEstimateSize(
  FlashcardSchemaModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.answer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.content.length * 3;
  {
    final list = object.options;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.source.name.length * 3;
  {
    final value = object.sourceFileName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subtitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tags;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _flashcardSchemaModelSerialize(
  FlashcardSchemaModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.answer);
  writer.writeDouble(offsets[1], object.confidenceScore);
  writer.writeString(offsets[2], object.content);
  writer.writeLong(offsets[3], object.correctOptionIndex);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeBool(offsets[5], object.isBookmarked);
  writer.writeBool(offsets[6], object.isCompleted);
  writer.writeDateTime(offsets[7], object.lastReviewedAt);
  writer.writeStringList(offsets[8], object.options);
  writer.writeLong(offsets[9], object.reviewCount);
  writer.writeString(offsets[10], object.source.name);
  writer.writeString(offsets[11], object.sourceFileName);
  writer.writeString(offsets[12], object.subtitle);
  writer.writeLong(offsets[13], object.tagColor);
  writer.writeString(offsets[14], object.tags);
  writer.writeString(offsets[15], object.title);
  writer.writeString(offsets[16], object.type.name);
  writer.writeDateTime(offsets[17], object.updatedAt);
}

FlashcardSchemaModel _flashcardSchemaModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashcardSchemaModel();
  object.answer = reader.readStringOrNull(offsets[0]);
  object.confidenceScore = reader.readDoubleOrNull(offsets[1]);
  object.content = reader.readString(offsets[2]);
  object.correctOptionIndex = reader.readLongOrNull(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.id = id;
  object.isBookmarked = reader.readBool(offsets[5]);
  object.isCompleted = reader.readBool(offsets[6]);
  object.lastReviewedAt = reader.readDateTimeOrNull(offsets[7]);
  object.options = reader.readStringList(offsets[8]);
  object.reviewCount = reader.readLong(offsets[9]);
  object.source =
      _FlashcardSchemaModelsourceValueEnumMap[reader.readStringOrNull(
        offsets[10],
      )] ??
      FlashcardSource.pdf;
  object.sourceFileName = reader.readStringOrNull(offsets[11]);
  object.subtitle = reader.readStringOrNull(offsets[12]);
  object.tagColor = reader.readLongOrNull(offsets[13]);
  object.tags = reader.readStringOrNull(offsets[14]);
  object.title = reader.readString(offsets[15]);
  object.type =
      _FlashcardSchemaModeltypeValueEnumMap[reader.readStringOrNull(
        offsets[16],
      )] ??
      FlashcardType.shortNotes;
  object.updatedAt = reader.readDateTime(offsets[17]);
  return object;
}

P _flashcardSchemaModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringList(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (_FlashcardSchemaModelsourceValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              FlashcardSource.pdf)
          as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (_FlashcardSchemaModeltypeValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              FlashcardType.shortNotes)
          as P;
    case 17:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FlashcardSchemaModelsourceEnumValueMap = {
  r'pdf': r'pdf',
  r'image': r'image',
  r'text': r'text',
  r'manual': r'manual',
};
const _FlashcardSchemaModelsourceValueEnumMap = {
  r'pdf': FlashcardSource.pdf,
  r'image': FlashcardSource.image,
  r'text': FlashcardSource.text,
  r'manual': FlashcardSource.manual,
};
const _FlashcardSchemaModeltypeEnumValueMap = {
  r'shortNotes': r'shortNotes',
  r'quiz': r'quiz',
  r'summary': r'summary',
};
const _FlashcardSchemaModeltypeValueEnumMap = {
  r'shortNotes': FlashcardType.shortNotes,
  r'quiz': FlashcardType.quiz,
  r'summary': FlashcardType.summary,
};

Id _flashcardSchemaModelGetId(FlashcardSchemaModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashcardSchemaModelGetLinks(
  FlashcardSchemaModel object,
) {
  return [];
}

void _flashcardSchemaModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  FlashcardSchemaModel object,
) {
  object.id = id;
}

extension FlashcardSchemaModelQueryWhereSort
    on QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QWhere> {
  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashcardSchemaModelQueryWhere
    on QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QWhereClause> {
  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FlashcardSchemaModelQueryFilter
    on
        QueryBuilder<
          FlashcardSchemaModel,
          FlashcardSchemaModel,
          QFilterCondition
        > {
  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'answer'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'answer'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'answer',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'answer',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'answer', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  answerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'answer', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  confidenceScoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'confidenceScore'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  confidenceScoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'confidenceScore'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  confidenceScoreEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'confidenceScore',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  confidenceScoreGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'confidenceScore',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  confidenceScoreLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'confidenceScore',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  confidenceScoreBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'confidenceScore',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'content',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'content',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'content', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'content', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  correctOptionIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'correctOptionIndex'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  correctOptionIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'correctOptionIndex'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  correctOptionIndexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'correctOptionIndex', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  correctOptionIndexGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'correctOptionIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  correctOptionIndexLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'correctOptionIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  correctOptionIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'correctOptionIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  isBookmarkedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isBookmarked', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCompleted', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  lastReviewedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastReviewedAt'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  lastReviewedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastReviewedAt'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  lastReviewedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastReviewedAt', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  lastReviewedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastReviewedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  lastReviewedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastReviewedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  lastReviewedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastReviewedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'options'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'options'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'options',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'options',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'options',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'options',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'options',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'options',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'options',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'options',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'options', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'options', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'options', length, true, length, true);
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'options', 0, true, 0, true);
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'options', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'options', 0, true, length, include);
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'options', length, include, 999999, true);
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  reviewCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reviewCount', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  reviewCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'reviewCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  reviewCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'reviewCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  reviewCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'reviewCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceEqualTo(FlashcardSource value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceGreaterThan(
    FlashcardSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceLessThan(
    FlashcardSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceBetween(
    FlashcardSource lower,
    FlashcardSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'source',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'source',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sourceFileName'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sourceFileName'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceFileName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceFileName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceFileName', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceFileName', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'subtitle'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'subtitle'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subtitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subtitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subtitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subtitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'subtitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'subtitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'subtitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'subtitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subtitle', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  subtitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'subtitle', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tagColor'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tagColor'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagColorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tagColor', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagColorGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tagColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagColorLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tagColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagColorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tagColor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tags'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tags'),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tags',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tags',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tags', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tags', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeEqualTo(FlashcardType value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeGreaterThan(
    FlashcardType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeLessThan(
    FlashcardType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeBetween(
    FlashcardType lower,
    FlashcardType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSchemaModel,
    FlashcardSchemaModel,
    QAfterFilterCondition
  >
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FlashcardSchemaModelQueryObject
    on
        QueryBuilder<
          FlashcardSchemaModel,
          FlashcardSchemaModel,
          QFilterCondition
        > {}

extension FlashcardSchemaModelQueryLinks
    on
        QueryBuilder<
          FlashcardSchemaModel,
          FlashcardSchemaModel,
          QFilterCondition
        > {}

extension FlashcardSchemaModelQuerySortBy
    on QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QSortBy> {
  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByCorrectOptionIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctOptionIndex', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByCorrectOptionIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctOptionIndex', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByIsBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmarked', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByIsBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmarked', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByLastReviewedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByLastReviewedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByReviewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByReviewCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortBySourceFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortBySourceFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortBySubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTagColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTagsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardSchemaModelQuerySortThenBy
    on QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QSortThenBy> {
  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByCorrectOptionIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctOptionIndex', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByCorrectOptionIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctOptionIndex', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByIsBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmarked', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByIsBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBookmarked', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByLastReviewedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByLastReviewedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByReviewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByReviewCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenBySourceFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenBySourceFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenBySubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTagColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTagsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tags', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardSchemaModelQueryWhereDistinct
    on QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct> {
  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByAnswer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidenceScore');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByCorrectOptionIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctOptionIndex');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByIsBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBookmarked');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByLastReviewedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReviewedAt');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByOptions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'options');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByReviewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewCount');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctBySourceFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'sourceFileName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctBySubtitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagColor');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByTags({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSchemaModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension FlashcardSchemaModelQueryProperty
    on
        QueryBuilder<
          FlashcardSchemaModel,
          FlashcardSchemaModel,
          QQueryProperty
        > {
  QueryBuilder<FlashcardSchemaModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashcardSchemaModel, String?, QQueryOperations>
  answerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answer');
    });
  }

  QueryBuilder<FlashcardSchemaModel, double?, QQueryOperations>
  confidenceScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidenceScore');
    });
  }

  QueryBuilder<FlashcardSchemaModel, String, QQueryOperations>
  contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<FlashcardSchemaModel, int?, QQueryOperations>
  correctOptionIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctOptionIndex');
    });
  }

  QueryBuilder<FlashcardSchemaModel, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FlashcardSchemaModel, bool, QQueryOperations>
  isBookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBookmarked');
    });
  }

  QueryBuilder<FlashcardSchemaModel, bool, QQueryOperations>
  isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<FlashcardSchemaModel, DateTime?, QQueryOperations>
  lastReviewedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReviewedAt');
    });
  }

  QueryBuilder<FlashcardSchemaModel, List<String>?, QQueryOperations>
  optionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'options');
    });
  }

  QueryBuilder<FlashcardSchemaModel, int, QQueryOperations>
  reviewCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewCount');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardSource, QQueryOperations>
  sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<FlashcardSchemaModel, String?, QQueryOperations>
  sourceFileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceFileName');
    });
  }

  QueryBuilder<FlashcardSchemaModel, String?, QQueryOperations>
  subtitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtitle');
    });
  }

  QueryBuilder<FlashcardSchemaModel, int?, QQueryOperations>
  tagColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagColor');
    });
  }

  QueryBuilder<FlashcardSchemaModel, String?, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<FlashcardSchemaModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<FlashcardSchemaModel, FlashcardType, QQueryOperations>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<FlashcardSchemaModel, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashcardSetSchemaModelCollection on Isar {
  IsarCollection<FlashcardSetSchemaModel> get flashcardSetSchemaModels =>
      this.collection();
}

const FlashcardSetSchemaModelSchema = CollectionSchema(
  name: r'FlashcardSetSchemaModel',
  id: -5618255376521490059,
  properties: {
    r'completedCards': PropertySchema(
      id: 0,
      name: r'completedCards',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'flashcardIds': PropertySchema(
      id: 3,
      name: r'flashcardIds',
      type: IsarType.longList,
    ),
    r'setName': PropertySchema(id: 4, name: r'setName', type: IsarType.string),
    r'source': PropertySchema(
      id: 5,
      name: r'source',
      type: IsarType.string,
      enumMap: _FlashcardSetSchemaModelsourceEnumValueMap,
    ),
    r'sourceFileName': PropertySchema(
      id: 6,
      name: r'sourceFileName',
      type: IsarType.string,
    ),
    r'tagColor': PropertySchema(id: 7, name: r'tagColor', type: IsarType.long),
    r'totalCards': PropertySchema(
      id: 8,
      name: r'totalCards',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _flashcardSetSchemaModelEstimateSize,
  serialize: _flashcardSetSchemaModelSerialize,
  deserialize: _flashcardSetSchemaModelDeserialize,
  deserializeProp: _flashcardSetSchemaModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _flashcardSetSchemaModelGetId,
  getLinks: _flashcardSetSchemaModelGetLinks,
  attach: _flashcardSetSchemaModelAttach,
  version: '3.3.0-dev.3',
);

int _flashcardSetSchemaModelEstimateSize(
  FlashcardSetSchemaModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.flashcardIds.length * 8;
  bytesCount += 3 + object.setName.length * 3;
  bytesCount += 3 + object.source.name.length * 3;
  {
    final value = object.sourceFileName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _flashcardSetSchemaModelSerialize(
  FlashcardSetSchemaModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedCards);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.description);
  writer.writeLongList(offsets[3], object.flashcardIds);
  writer.writeString(offsets[4], object.setName);
  writer.writeString(offsets[5], object.source.name);
  writer.writeString(offsets[6], object.sourceFileName);
  writer.writeLong(offsets[7], object.tagColor);
  writer.writeLong(offsets[8], object.totalCards);
  writer.writeDateTime(offsets[9], object.updatedAt);
}

FlashcardSetSchemaModel _flashcardSetSchemaModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashcardSetSchemaModel();
  object.completedCards = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.description = reader.readStringOrNull(offsets[2]);
  object.flashcardIds = reader.readLongList(offsets[3]) ?? [];
  object.id = id;
  object.setName = reader.readString(offsets[4]);
  object.source =
      _FlashcardSetSchemaModelsourceValueEnumMap[reader.readStringOrNull(
        offsets[5],
      )] ??
      FlashcardSource.pdf;
  object.sourceFileName = reader.readStringOrNull(offsets[6]);
  object.tagColor = reader.readLongOrNull(offsets[7]);
  object.totalCards = reader.readLong(offsets[8]);
  object.updatedAt = reader.readDateTime(offsets[9]);
  return object;
}

P _flashcardSetSchemaModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (_FlashcardSetSchemaModelsourceValueEnumMap[reader
                  .readStringOrNull(offset)] ??
              FlashcardSource.pdf)
          as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FlashcardSetSchemaModelsourceEnumValueMap = {
  r'pdf': r'pdf',
  r'image': r'image',
  r'text': r'text',
  r'manual': r'manual',
};
const _FlashcardSetSchemaModelsourceValueEnumMap = {
  r'pdf': FlashcardSource.pdf,
  r'image': FlashcardSource.image,
  r'text': FlashcardSource.text,
  r'manual': FlashcardSource.manual,
};

Id _flashcardSetSchemaModelGetId(FlashcardSetSchemaModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashcardSetSchemaModelGetLinks(
  FlashcardSetSchemaModel object,
) {
  return [];
}

void _flashcardSetSchemaModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  FlashcardSetSchemaModel object,
) {
  object.id = id;
}

extension FlashcardSetSchemaModelQueryWhereSort
    on QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QWhere> {
  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashcardSetSchemaModelQueryWhere
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QWhereClause
        > {
  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FlashcardSetSchemaModelQueryFilter
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QFilterCondition
        > {
  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  completedCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'completedCards', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  completedCardsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'completedCards',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  completedCardsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'completedCards',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  completedCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'completedCards',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'description'),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'description'),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'flashcardIds', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'flashcardIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'flashcardIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'flashcardIds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'flashcardIds', length, true, length, true);
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'flashcardIds', 0, true, 0, true);
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'flashcardIds', 0, false, 999999, true);
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'flashcardIds', 0, true, length, include);
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'flashcardIds', length, include, 999999, true);
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  flashcardIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'flashcardIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'setName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'setName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'setName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'setName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'setName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'setName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'setName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'setName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'setName', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  setNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'setName', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceEqualTo(FlashcardSource value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceGreaterThan(
    FlashcardSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceLessThan(
    FlashcardSource value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceBetween(
    FlashcardSource lower,
    FlashcardSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'source',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'source',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sourceFileName'),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sourceFileName'),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceFileName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceFileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceFileName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceFileName', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  sourceFileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceFileName', value: ''),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  tagColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'tagColor'),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  tagColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'tagColor'),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  tagColorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tagColor', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  tagColorGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tagColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  tagColorLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tagColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  tagColorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tagColor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  totalCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalCards', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  totalCardsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalCards',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  totalCardsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalCards',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  totalCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalCards',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    FlashcardSetSchemaModel,
    FlashcardSetSchemaModel,
    QAfterFilterCondition
  >
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FlashcardSetSchemaModelQueryObject
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QFilterCondition
        > {}

extension FlashcardSetSchemaModelQueryLinks
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QFilterCondition
        > {}

extension FlashcardSetSchemaModelQuerySortBy
    on QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QSortBy> {
  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByCompletedCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByCompletedCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortBySetName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setName', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortBySetNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setName', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortBySourceFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortBySourceFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByTagColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardSetSchemaModelQuerySortThenBy
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QSortThenBy
        > {
  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByCompletedCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByCompletedCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenBySetName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setName', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenBySetNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'setName', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenBySourceFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenBySourceFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceFileName', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByTagColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardSetSchemaModelQueryWhereDistinct
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QDistinct
        > {
  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByCompletedCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedCards');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByFlashcardIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'flashcardIds');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctBySetName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'setName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctBySourceFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'sourceFileName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagColor');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCards');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSetSchemaModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension FlashcardSetSchemaModelQueryProperty
    on
        QueryBuilder<
          FlashcardSetSchemaModel,
          FlashcardSetSchemaModel,
          QQueryProperty
        > {
  QueryBuilder<FlashcardSetSchemaModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, int, QQueryOperations>
  completedCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedCards');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, String?, QQueryOperations>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, List<int>, QQueryOperations>
  flashcardIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flashcardIds');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, String, QQueryOperations>
  setNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'setName');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, FlashcardSource, QQueryOperations>
  sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, String?, QQueryOperations>
  sourceFileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceFileName');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, int?, QQueryOperations>
  tagColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagColor');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, int, QQueryOperations>
  totalCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCards');
    });
  }

  QueryBuilder<FlashcardSetSchemaModel, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
