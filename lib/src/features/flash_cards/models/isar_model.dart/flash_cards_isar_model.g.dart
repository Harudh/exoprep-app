// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_cards_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashCardsIsarModelCollection on Isar {
  IsarCollection<FlashCardsIsarModel> get flashCardsIsarModels =>
      this.collection();
}

const FlashCardsIsarModelSchema = CollectionSchema(
  name: r'FlashCardsIsarModel',
  id: -714896459683052428,
  properties: {
    r'answerImages': PropertySchema(
      id: 0,
      name: r'answerImages',
      type: IsarType.stringList,
    ),
    r'answerText': PropertySchema(
      id: 1,
      name: r'answerText',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deckId': PropertySchema(id: 3, name: r'deckId', type: IsarType.string),
    r'deletedAt': PropertySchema(
      id: 4,
      name: r'deletedAt',
      type: IsarType.dateTime,
    ),
    r'orderIndex': PropertySchema(
      id: 5,
      name: r'orderIndex',
      type: IsarType.long,
    ),
    r'questionImages': PropertySchema(
      id: 6,
      name: r'questionImages',
      type: IsarType.stringList,
    ),
    r'questionText': PropertySchema(
      id: 7,
      name: r'questionText',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _flashCardsIsarModelEstimateSize,
  serialize: _flashCardsIsarModelSerialize,
  deserialize: _flashCardsIsarModelDeserialize,
  deserializeProp: _flashCardsIsarModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'deckId': IndexSchema(
      id: -1182505463565197889,
      name: r'deckId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deckId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _flashCardsIsarModelGetId,
  getLinks: _flashCardsIsarModelGetLinks,
  attach: _flashCardsIsarModelAttach,
  version: '3.3.0-dev.3',
);

int _flashCardsIsarModelEstimateSize(
  FlashCardsIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.answerImages;
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
  {
    final value = object.answerText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deckId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.questionImages;
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
  {
    final value = object.questionText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _flashCardsIsarModelSerialize(
  FlashCardsIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.answerImages);
  writer.writeString(offsets[1], object.answerText);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.deckId);
  writer.writeDateTime(offsets[4], object.deletedAt);
  writer.writeLong(offsets[5], object.orderIndex);
  writer.writeStringList(offsets[6], object.questionImages);
  writer.writeString(offsets[7], object.questionText);
  writer.writeDateTime(offsets[8], object.updatedAt);
}

FlashCardsIsarModel _flashCardsIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashCardsIsarModel();
  object.answerImages = reader.readStringList(offsets[0]);
  object.answerText = reader.readStringOrNull(offsets[1]);
  object.createdAt = reader.readDateTimeOrNull(offsets[2]);
  object.deckId = reader.readStringOrNull(offsets[3]);
  object.deletedAt = reader.readDateTimeOrNull(offsets[4]);
  object.id = id;
  object.orderIndex = reader.readLongOrNull(offsets[5]);
  object.questionImages = reader.readStringList(offsets[6]);
  object.questionText = reader.readStringOrNull(offsets[7]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[8]);
  return object;
}

P _flashCardsIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringList(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _flashCardsIsarModelGetId(FlashCardsIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashCardsIsarModelGetLinks(
  FlashCardsIsarModel object,
) {
  return [];
}

void _flashCardsIsarModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  FlashCardsIsarModel object,
) {
  object.id = id;
}

extension FlashCardsIsarModelQueryWhereSort
    on QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QWhere> {
  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashCardsIsarModelQueryWhere
    on QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QWhereClause> {
  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  deckIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'deckId', value: [null]),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  deckIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'deckId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  deckIdEqualTo(String? deckId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'deckId', value: [deckId]),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterWhereClause>
  deckIdNotEqualTo(String? deckId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'deckId',
                lower: [],
                upper: [deckId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'deckId',
                lower: [deckId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'deckId',
                lower: [deckId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'deckId',
                lower: [],
                upper: [deckId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension FlashCardsIsarModelQueryFilter
    on
        QueryBuilder<
          FlashCardsIsarModel,
          FlashCardsIsarModel,
          QFilterCondition
        > {
  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'answerImages'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'answerImages'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'answerImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'answerImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'answerImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'answerImages',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'answerImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'answerImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'answerImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'answerImages',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'answerImages', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'answerImages', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'answerImages', length, true, length, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'answerImages', 0, true, 0, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'answerImages', 0, false, 999999, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'answerImages', 0, true, length, include);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'answerImages', length, include, 999999, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerImagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answerImages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'answerText'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'answerText'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'answerText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'answerText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'answerText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'answerText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'answerText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'answerText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'answerText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'answerText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'answerText', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  answerTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'answerText', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  createdAtLessThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'deckId'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'deckId'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'deckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'deckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'deckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'deckId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'deckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'deckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'deckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'deckId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'deckId', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deckIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'deckId', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'deletedAt'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'deletedAt'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deletedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'deletedAt', value: value),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deletedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'deletedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deletedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'deletedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  deletedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'deletedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  orderIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'orderIndex'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  orderIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'orderIndex'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  orderIndexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'orderIndex', value: value),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  orderIndexGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'orderIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  orderIndexLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'orderIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  orderIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'orderIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'questionImages'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'questionImages'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'questionImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'questionImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'questionImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'questionImages',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'questionImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'questionImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'questionImages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'questionImages',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'questionImages', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'questionImages', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'questionImages', length, true, length, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'questionImages', 0, true, 0, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'questionImages', 0, false, 999999, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'questionImages', 0, true, length, include);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'questionImages', length, include, 999999, true);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionImagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionImages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'questionText'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'questionText'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'questionText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'questionText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'questionText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'questionText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'questionText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'questionText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'questionText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'questionText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'questionText', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  questionTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'questionText', value: ''),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  updatedAtLessThan(DateTime? value, {bool include = false}) {
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

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterFilterCondition>
  updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

extension FlashCardsIsarModelQueryObject
    on
        QueryBuilder<
          FlashCardsIsarModel,
          FlashCardsIsarModel,
          QFilterCondition
        > {}

extension FlashCardsIsarModelQueryLinks
    on
        QueryBuilder<
          FlashCardsIsarModel,
          FlashCardsIsarModel,
          QFilterCondition
        > {}

extension FlashCardsIsarModelQuerySortBy
    on QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QSortBy> {
  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByAnswerText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByAnswerTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByDeckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByQuestionText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByQuestionTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashCardsIsarModelQuerySortThenBy
    on QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QSortThenBy> {
  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByAnswerText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByAnswerTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerText', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByDeckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByOrderIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderIndex', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByQuestionText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByQuestionTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.desc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashCardsIsarModelQueryWhereDistinct
    on QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct> {
  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByAnswerImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answerImages');
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByAnswerText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answerText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByDeckId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deletedAt');
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByOrderIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderIndex');
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByQuestionImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionImages');
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByQuestionText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension FlashCardsIsarModelQueryProperty
    on QueryBuilder<FlashCardsIsarModel, FlashCardsIsarModel, QQueryProperty> {
  QueryBuilder<FlashCardsIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashCardsIsarModel, List<String>?, QQueryOperations>
  answerImagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answerImages');
    });
  }

  QueryBuilder<FlashCardsIsarModel, String?, QQueryOperations>
  answerTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answerText');
    });
  }

  QueryBuilder<FlashCardsIsarModel, DateTime?, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FlashCardsIsarModel, String?, QQueryOperations>
  deckIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckId');
    });
  }

  QueryBuilder<FlashCardsIsarModel, DateTime?, QQueryOperations>
  deletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deletedAt');
    });
  }

  QueryBuilder<FlashCardsIsarModel, int?, QQueryOperations>
  orderIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderIndex');
    });
  }

  QueryBuilder<FlashCardsIsarModel, List<String>?, QQueryOperations>
  questionImagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionImages');
    });
  }

  QueryBuilder<FlashCardsIsarModel, String?, QQueryOperations>
  questionTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionText');
    });
  }

  QueryBuilder<FlashCardsIsarModel, DateTime?, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
