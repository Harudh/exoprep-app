// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_schema_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProjectSchemaModelCollection on Isar {
  IsarCollection<ProjectSchemaModel> get projectSchemaModels =>
      this.collection();
}

const ProjectSchemaModelSchema = CollectionSchema(
  name: r'ProjectSchemaModel',
  id: -5215058053692920852,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'hasTimeGoal': PropertySchema(
      id: 1,
      name: r'hasTimeGoal',
      type: IsarType.bool,
    ),
    r'projectName': PropertySchema(
      id: 2,
      name: r'projectName',
      type: IsarType.string,
    ),
    r'tagColor': PropertySchema(id: 3, name: r'tagColor', type: IsarType.long),
    r'timeGoalDurationMinutes': PropertySchema(
      id: 4,
      name: r'timeGoalDurationMinutes',
      type: IsarType.long,
    ),
    r'timeGoalFrequency': PropertySchema(
      id: 5,
      name: r'timeGoalFrequency',
      type: IsarType.string,
      enumMap: _ProjectSchemaModeltimeGoalFrequencyEnumValueMap,
    ),
    r'timeGoalOneTimeDeadlineDate': PropertySchema(
      id: 6,
      name: r'timeGoalOneTimeDeadlineDate',
      type: IsarType.dateTime,
    ),
    r'timeGoalOneTimeHasDeadlineDate': PropertySchema(
      id: 7,
      name: r'timeGoalOneTimeHasDeadlineDate',
      type: IsarType.bool,
    ),
    r'timeGoalOneTimeStartDate': PropertySchema(
      id: 8,
      name: r'timeGoalOneTimeStartDate',
      type: IsarType.dateTime,
    ),
    r'timeGoalRepeatingFrequency': PropertySchema(
      id: 9,
      name: r'timeGoalRepeatingFrequency',
      type: IsarType.string,
      enumMap: _ProjectSchemaModeltimeGoalRepeatingFrequencyEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _projectSchemaModelEstimateSize,
  serialize: _projectSchemaModelSerialize,
  deserialize: _projectSchemaModelDeserialize,
  deserializeProp: _projectSchemaModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'projectName': IndexSchema(
      id: 7457588439029069741,
      name: r'projectName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'projectName',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
    r'tagColor': IndexSchema(
      id: 3923155393009563304,
      name: r'tagColor',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tagColor',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _projectSchemaModelGetId,
  getLinks: _projectSchemaModelGetLinks,
  attach: _projectSchemaModelAttach,
  version: '3.3.0-dev.3',
);

int _projectSchemaModelEstimateSize(
  ProjectSchemaModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.projectName.length * 3;
  {
    final value = object.timeGoalFrequency;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.timeGoalRepeatingFrequency;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _projectSchemaModelSerialize(
  ProjectSchemaModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.hasTimeGoal);
  writer.writeString(offsets[2], object.projectName);
  writer.writeLong(offsets[3], object.tagColor);
  writer.writeLong(offsets[4], object.timeGoalDurationMinutes);
  writer.writeString(offsets[5], object.timeGoalFrequency?.name);
  writer.writeDateTime(offsets[6], object.timeGoalOneTimeDeadlineDate);
  writer.writeBool(offsets[7], object.timeGoalOneTimeHasDeadlineDate);
  writer.writeDateTime(offsets[8], object.timeGoalOneTimeStartDate);
  writer.writeString(offsets[9], object.timeGoalRepeatingFrequency?.name);
  writer.writeDateTime(offsets[10], object.updatedAt);
}

ProjectSchemaModel _projectSchemaModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProjectSchemaModel(
    createdAt: reader.readDateTimeOrNull(offsets[0]),
    hasTimeGoal: reader.readBoolOrNull(offsets[1]) ?? false,
    id: id,
    projectName: reader.readString(offsets[2]),
    tagColor: reader.readLong(offsets[3]),
    timeGoalDurationMinutes: reader.readLongOrNull(offsets[4]),
    timeGoalFrequency:
        _ProjectSchemaModeltimeGoalFrequencyValueEnumMap[reader
            .readStringOrNull(offsets[5])],
    timeGoalOneTimeDeadlineDate: reader.readDateTimeOrNull(offsets[6]),
    timeGoalOneTimeHasDeadlineDate: reader.readBoolOrNull(offsets[7]) ?? false,
    timeGoalOneTimeStartDate: reader.readDateTimeOrNull(offsets[8]),
    timeGoalRepeatingFrequency:
        _ProjectSchemaModeltimeGoalRepeatingFrequencyValueEnumMap[reader
            .readStringOrNull(offsets[9])],
    updatedAt: reader.readDateTimeOrNull(offsets[10]),
  );
  return object;
}

P _projectSchemaModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (_ProjectSchemaModeltimeGoalFrequencyValueEnumMap[reader
              .readStringOrNull(offset)])
          as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (_ProjectSchemaModeltimeGoalRepeatingFrequencyValueEnumMap[reader
              .readStringOrNull(offset)])
          as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ProjectSchemaModeltimeGoalFrequencyEnumValueMap = {
  r'onetime': r'onetime',
  r'recurring': r'recurring',
};
const _ProjectSchemaModeltimeGoalFrequencyValueEnumMap = {
  r'onetime': TimeGoalFrequency.onetime,
  r'recurring': TimeGoalFrequency.recurring,
};
const _ProjectSchemaModeltimeGoalRepeatingFrequencyEnumValueMap = {
  r'daily': r'daily',
  r'weekly': r'weekly',
  r'monthly': r'monthly',
};
const _ProjectSchemaModeltimeGoalRepeatingFrequencyValueEnumMap = {
  r'daily': TimeGoalRepeatingFrequency.daily,
  r'weekly': TimeGoalRepeatingFrequency.weekly,
  r'monthly': TimeGoalRepeatingFrequency.monthly,
};

Id _projectSchemaModelGetId(ProjectSchemaModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _projectSchemaModelGetLinks(
  ProjectSchemaModel object,
) {
  return [];
}

void _projectSchemaModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ProjectSchemaModel object,
) {
  object.id = id;
}

extension ProjectSchemaModelQueryWhereSort
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QWhere> {
  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhere>
  anyProjectName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'projectName'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhere>
  anyTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tagColor'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhere>
  anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension ProjectSchemaModelQueryWhere
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QWhereClause> {
  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameEqualTo(String projectName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'projectName',
          value: [projectName],
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameNotEqualTo(String projectName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'projectName',
                lower: [],
                upper: [projectName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'projectName',
                lower: [projectName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'projectName',
                lower: [projectName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'projectName',
                lower: [],
                upper: [projectName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameGreaterThan(String projectName, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'projectName',
          lower: [projectName],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameLessThan(String projectName, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'projectName',
          lower: [],
          upper: [projectName],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameBetween(
    String lowerProjectName,
    String upperProjectName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'projectName',
          lower: [lowerProjectName],
          includeLower: includeLower,
          upper: [upperProjectName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameStartsWith(String ProjectNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'projectName',
          lower: [ProjectNamePrefix],
          upper: ['$ProjectNamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'projectName', value: ['']),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  projectNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'projectName', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'projectName',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'projectName',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'projectName', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  tagColorEqualTo(int tagColor) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'tagColor', value: [tagColor]),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  tagColorNotEqualTo(int tagColor) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'tagColor',
                lower: [],
                upper: [tagColor],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'tagColor',
                lower: [tagColor],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'tagColor',
                lower: [tagColor],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'tagColor',
                lower: [],
                upper: [tagColor],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  tagColorGreaterThan(int tagColor, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'tagColor',
          lower: [tagColor],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  tagColorLessThan(int tagColor, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'tagColor',
          lower: [],
          upper: [tagColor],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  tagColorBetween(
    int lowerTagColor,
    int upperTagColor, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'tagColor',
          lower: [lowerTagColor],
          includeLower: includeLower,
          upper: [upperTagColor],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [null]),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'createdAt', value: [createdAt]),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtNotEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [createdAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'createdAt',
                lower: [],
                upper: [createdAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtGreaterThan(DateTime? createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [createdAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtLessThan(DateTime? createdAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [],
          upper: [createdAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterWhereClause>
  createdAtBetween(
    DateTime? lowerCreatedAt,
    DateTime? upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'createdAt',
          lower: [lowerCreatedAt],
          includeLower: includeLower,
          upper: [upperCreatedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ProjectSchemaModelQueryFilter
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QFilterCondition> {
  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  hasTimeGoalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hasTimeGoal', value: value),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'projectName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'projectName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'projectName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'projectName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'projectName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'projectName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'projectName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'projectName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'projectName', value: ''),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  projectNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'projectName', value: ''),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  tagColorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tagColor', value: value),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  tagColorGreaterThan(int value, {bool include = false}) {
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  tagColorLessThan(int value, {bool include = false}) {
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  tagColorBetween(
    int lower,
    int upper, {
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalDurationMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeGoalDurationMinutes'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalDurationMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeGoalDurationMinutes'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalDurationMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalDurationMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalDurationMinutesGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeGoalDurationMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalDurationMinutesLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeGoalDurationMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalDurationMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeGoalDurationMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeGoalFrequency'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeGoalFrequency'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyEqualTo(
    TimeGoalFrequency? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyGreaterThan(
    TimeGoalFrequency? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeGoalFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyLessThan(
    TimeGoalFrequency? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeGoalFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyBetween(
    TimeGoalFrequency? lower,
    TimeGoalFrequency? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeGoalFrequency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeGoalFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeGoalFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeGoalFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeGoalFrequency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'timeGoalFrequency', value: ''),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalFrequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'timeGoalFrequency', value: ''),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeDeadlineDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeGoalOneTimeDeadlineDate'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeDeadlineDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'timeGoalOneTimeDeadlineDate',
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeDeadlineDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalOneTimeDeadlineDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeDeadlineDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeGoalOneTimeDeadlineDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeDeadlineDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeGoalOneTimeDeadlineDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeDeadlineDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeGoalOneTimeDeadlineDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeHasDeadlineDateEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalOneTimeHasDeadlineDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeStartDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeGoalOneTimeStartDate'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeStartDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'timeGoalOneTimeStartDate'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeStartDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalOneTimeStartDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeStartDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeGoalOneTimeStartDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeStartDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeGoalOneTimeStartDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalOneTimeStartDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeGoalOneTimeStartDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'timeGoalRepeatingFrequency'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'timeGoalRepeatingFrequency',
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyEqualTo(
    TimeGoalRepeatingFrequency? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalRepeatingFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyGreaterThan(
    TimeGoalRepeatingFrequency? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'timeGoalRepeatingFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyLessThan(
    TimeGoalRepeatingFrequency? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'timeGoalRepeatingFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyBetween(
    TimeGoalRepeatingFrequency? lower,
    TimeGoalRepeatingFrequency? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'timeGoalRepeatingFrequency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'timeGoalRepeatingFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'timeGoalRepeatingFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'timeGoalRepeatingFrequency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'timeGoalRepeatingFrequency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'timeGoalRepeatingFrequency',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  timeGoalRepeatingFrequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'timeGoalRepeatingFrequency',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
  updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterFilterCondition>
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

extension ProjectSchemaModelQueryObject
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QFilterCondition> {}

extension ProjectSchemaModelQueryLinks
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QFilterCondition> {}

extension ProjectSchemaModelQuerySortBy
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QSortBy> {
  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByHasTimeGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeGoal', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByHasTimeGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeGoal', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByProjectName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectName', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByProjectNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectName', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTagColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalFrequency', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalFrequency', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalOneTimeDeadlineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeDeadlineDate', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalOneTimeDeadlineDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeDeadlineDate', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalOneTimeHasDeadlineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeHasDeadlineDate', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalOneTimeHasDeadlineDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeHasDeadlineDate', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalOneTimeStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeStartDate', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalOneTimeStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeStartDate', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalRepeatingFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalRepeatingFrequency', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByTimeGoalRepeatingFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalRepeatingFrequency', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ProjectSchemaModelQuerySortThenBy
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QSortThenBy> {
  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByHasTimeGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeGoal', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByHasTimeGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTimeGoal', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByProjectName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectName', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByProjectNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectName', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTagColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColor', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalFrequency', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalFrequency', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalOneTimeDeadlineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeDeadlineDate', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalOneTimeDeadlineDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeDeadlineDate', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalOneTimeHasDeadlineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeHasDeadlineDate', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalOneTimeHasDeadlineDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeHasDeadlineDate', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalOneTimeStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeStartDate', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalOneTimeStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalOneTimeStartDate', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalRepeatingFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalRepeatingFrequency', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByTimeGoalRepeatingFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeGoalRepeatingFrequency', Sort.desc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ProjectSchemaModelQueryWhereDistinct
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct> {
  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByHasTimeGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasTimeGoal');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByProjectName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'projectName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTagColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagColor');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTimeGoalDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeGoalDurationMinutes');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTimeGoalFrequency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'timeGoalFrequency',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTimeGoalOneTimeDeadlineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeGoalOneTimeDeadlineDate');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTimeGoalOneTimeHasDeadlineDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeGoalOneTimeHasDeadlineDate');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTimeGoalOneTimeStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeGoalOneTimeStartDate');
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByTimeGoalRepeatingFrequency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'timeGoalRepeatingFrequency',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ProjectSchemaModelQueryProperty
    on QueryBuilder<ProjectSchemaModel, ProjectSchemaModel, QQueryProperty> {
  QueryBuilder<ProjectSchemaModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProjectSchemaModel, DateTime?, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ProjectSchemaModel, bool, QQueryOperations>
  hasTimeGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasTimeGoal');
    });
  }

  QueryBuilder<ProjectSchemaModel, String, QQueryOperations>
  projectNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'projectName');
    });
  }

  QueryBuilder<ProjectSchemaModel, int, QQueryOperations> tagColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagColor');
    });
  }

  QueryBuilder<ProjectSchemaModel, int?, QQueryOperations>
  timeGoalDurationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeGoalDurationMinutes');
    });
  }

  QueryBuilder<ProjectSchemaModel, TimeGoalFrequency?, QQueryOperations>
  timeGoalFrequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeGoalFrequency');
    });
  }

  QueryBuilder<ProjectSchemaModel, DateTime?, QQueryOperations>
  timeGoalOneTimeDeadlineDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeGoalOneTimeDeadlineDate');
    });
  }

  QueryBuilder<ProjectSchemaModel, bool, QQueryOperations>
  timeGoalOneTimeHasDeadlineDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeGoalOneTimeHasDeadlineDate');
    });
  }

  QueryBuilder<ProjectSchemaModel, DateTime?, QQueryOperations>
  timeGoalOneTimeStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeGoalOneTimeStartDate');
    });
  }

  QueryBuilder<
    ProjectSchemaModel,
    TimeGoalRepeatingFrequency?,
    QQueryOperations
  >
  timeGoalRepeatingFrequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeGoalRepeatingFrequency');
    });
  }

  QueryBuilder<ProjectSchemaModel, DateTime?, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
