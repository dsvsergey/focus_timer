// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_persistence.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimerPersistenceCollection on Isar {
  IsarCollection<TimerPersistence> get timerPersistences => this.collection();
}

const TimerPersistenceSchema = CollectionSchema(
  name: r'TimerPersistence',
  id: -5303579990379430898,
  properties: {
    r'completedCycles': PropertySchema(
      id: 0,
      name: r'completedCycles',
      type: IsarType.long,
    ),
    r'currentCycleStep': PropertySchema(
      id: 1,
      name: r'currentCycleStep',
      type: IsarType.long,
    ),
    r'currentSessionType': PropertySchema(
      id: 2,
      name: r'currentSessionType',
      type: IsarType.string,
      enumMap: _TimerPersistencecurrentSessionTypeEnumValueMap,
    ),
    r'lastSaveTime': PropertySchema(
      id: 3,
      name: r'lastSaveTime',
      type: IsarType.dateTime,
    ),
    r'remainingSeconds': PropertySchema(
      id: 4,
      name: r'remainingSeconds',
      type: IsarType.long,
    ),
    r'totalFocusSessions': PropertySchema(
      id: 5,
      name: r'totalFocusSessions',
      type: IsarType.long,
    ),
    r'wasPaused': PropertySchema(
      id: 6,
      name: r'wasPaused',
      type: IsarType.bool,
    ),
    r'wasRunning': PropertySchema(
      id: 7,
      name: r'wasRunning',
      type: IsarType.bool,
    )
  },
  estimateSize: _timerPersistenceEstimateSize,
  serialize: _timerPersistenceSerialize,
  deserialize: _timerPersistenceDeserialize,
  deserializeProp: _timerPersistenceDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _timerPersistenceGetId,
  getLinks: _timerPersistenceGetLinks,
  attach: _timerPersistenceAttach,
  version: '3.1.0+1',
);

int _timerPersistenceEstimateSize(
  TimerPersistence object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currentSessionType.name.length * 3;
  return bytesCount;
}

void _timerPersistenceSerialize(
  TimerPersistence object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedCycles);
  writer.writeLong(offsets[1], object.currentCycleStep);
  writer.writeString(offsets[2], object.currentSessionType.name);
  writer.writeDateTime(offsets[3], object.lastSaveTime);
  writer.writeLong(offsets[4], object.remainingSeconds);
  writer.writeLong(offsets[5], object.totalFocusSessions);
  writer.writeBool(offsets[6], object.wasPaused);
  writer.writeBool(offsets[7], object.wasRunning);
}

TimerPersistence _timerPersistenceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimerPersistence();
  object.completedCycles = reader.readLong(offsets[0]);
  object.currentCycleStep = reader.readLong(offsets[1]);
  object.currentSessionType = _TimerPersistencecurrentSessionTypeValueEnumMap[
          reader.readStringOrNull(offsets[2])] ??
      SessionType.focus;
  object.id = id;
  object.lastSaveTime = reader.readDateTime(offsets[3]);
  object.remainingSeconds = reader.readLong(offsets[4]);
  object.totalFocusSessions = reader.readLong(offsets[5]);
  object.wasPaused = reader.readBool(offsets[6]);
  object.wasRunning = reader.readBool(offsets[7]);
  return object;
}

P _timerPersistenceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_TimerPersistencecurrentSessionTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          SessionType.focus) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TimerPersistencecurrentSessionTypeEnumValueMap = {
  r'focus': r'focus',
  r'shortBreak': r'shortBreak',
  r'longBreak': r'longBreak',
};
const _TimerPersistencecurrentSessionTypeValueEnumMap = {
  r'focus': SessionType.focus,
  r'shortBreak': SessionType.shortBreak,
  r'longBreak': SessionType.longBreak,
};

Id _timerPersistenceGetId(TimerPersistence object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timerPersistenceGetLinks(TimerPersistence object) {
  return [];
}

void _timerPersistenceAttach(
    IsarCollection<dynamic> col, Id id, TimerPersistence object) {
  object.id = id;
}

extension TimerPersistenceQueryWhereSort
    on QueryBuilder<TimerPersistence, TimerPersistence, QWhere> {
  QueryBuilder<TimerPersistence, TimerPersistence, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimerPersistenceQueryWhere
    on QueryBuilder<TimerPersistence, TimerPersistence, QWhereClause> {
  QueryBuilder<TimerPersistence, TimerPersistence, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterWhereClause>
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

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimerPersistenceQueryFilter
    on QueryBuilder<TimerPersistence, TimerPersistence, QFilterCondition> {
  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      completedCyclesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedCycles',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      completedCyclesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedCycles',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      completedCyclesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedCycles',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      completedCyclesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedCycles',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentCycleStepEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentCycleStep',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentCycleStepGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentCycleStep',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentCycleStepLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentCycleStep',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentCycleStepBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentCycleStep',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeEqualTo(
    SessionType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentSessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeGreaterThan(
    SessionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentSessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeLessThan(
    SessionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentSessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeBetween(
    SessionType lower,
    SessionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentSessionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentSessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentSessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentSessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentSessionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentSessionType',
        value: '',
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      currentSessionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentSessionType',
        value: '',
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      lastSaveTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSaveTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      lastSaveTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSaveTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      lastSaveTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSaveTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      lastSaveTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSaveTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      remainingSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remainingSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      remainingSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remainingSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      remainingSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remainingSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      remainingSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remainingSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      totalFocusSessionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFocusSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      totalFocusSessionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFocusSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      totalFocusSessionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFocusSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      totalFocusSessionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFocusSessions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      wasPausedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wasPaused',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterFilterCondition>
      wasRunningEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wasRunning',
        value: value,
      ));
    });
  }
}

extension TimerPersistenceQueryObject
    on QueryBuilder<TimerPersistence, TimerPersistence, QFilterCondition> {}

extension TimerPersistenceQueryLinks
    on QueryBuilder<TimerPersistence, TimerPersistence, QFilterCondition> {}

extension TimerPersistenceQuerySortBy
    on QueryBuilder<TimerPersistence, TimerPersistence, QSortBy> {
  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByCompletedCycles() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCycles', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByCompletedCyclesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCycles', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByCurrentCycleStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentCycleStep', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByCurrentCycleStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentCycleStep', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByCurrentSessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionType', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByCurrentSessionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionType', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByLastSaveTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSaveTime', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByLastSaveTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSaveTime', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByRemainingSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingSeconds', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByRemainingSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingSeconds', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByTotalFocusSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusSessions', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByTotalFocusSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusSessions', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByWasPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasPaused', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByWasPausedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasPaused', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByWasRunning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRunning', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      sortByWasRunningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRunning', Sort.desc);
    });
  }
}

extension TimerPersistenceQuerySortThenBy
    on QueryBuilder<TimerPersistence, TimerPersistence, QSortThenBy> {
  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByCompletedCycles() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCycles', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByCompletedCyclesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCycles', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByCurrentCycleStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentCycleStep', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByCurrentCycleStepDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentCycleStep', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByCurrentSessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionType', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByCurrentSessionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentSessionType', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByLastSaveTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSaveTime', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByLastSaveTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSaveTime', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByRemainingSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingSeconds', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByRemainingSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingSeconds', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByTotalFocusSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusSessions', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByTotalFocusSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusSessions', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByWasPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasPaused', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByWasPausedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasPaused', Sort.desc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByWasRunning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRunning', Sort.asc);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QAfterSortBy>
      thenByWasRunningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRunning', Sort.desc);
    });
  }
}

extension TimerPersistenceQueryWhereDistinct
    on QueryBuilder<TimerPersistence, TimerPersistence, QDistinct> {
  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByCompletedCycles() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedCycles');
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByCurrentCycleStep() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentCycleStep');
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByCurrentSessionType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentSessionType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByLastSaveTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSaveTime');
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByRemainingSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remainingSeconds');
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByTotalFocusSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFocusSessions');
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByWasPaused() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wasPaused');
    });
  }

  QueryBuilder<TimerPersistence, TimerPersistence, QDistinct>
      distinctByWasRunning() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wasRunning');
    });
  }
}

extension TimerPersistenceQueryProperty
    on QueryBuilder<TimerPersistence, TimerPersistence, QQueryProperty> {
  QueryBuilder<TimerPersistence, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimerPersistence, int, QQueryOperations>
      completedCyclesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedCycles');
    });
  }

  QueryBuilder<TimerPersistence, int, QQueryOperations>
      currentCycleStepProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentCycleStep');
    });
  }

  QueryBuilder<TimerPersistence, SessionType, QQueryOperations>
      currentSessionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentSessionType');
    });
  }

  QueryBuilder<TimerPersistence, DateTime, QQueryOperations>
      lastSaveTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSaveTime');
    });
  }

  QueryBuilder<TimerPersistence, int, QQueryOperations>
      remainingSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remainingSeconds');
    });
  }

  QueryBuilder<TimerPersistence, int, QQueryOperations>
      totalFocusSessionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFocusSessions');
    });
  }

  QueryBuilder<TimerPersistence, bool, QQueryOperations> wasPausedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wasPaused');
    });
  }

  QueryBuilder<TimerPersistence, bool, QQueryOperations> wasRunningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wasRunning');
    });
  }
}
