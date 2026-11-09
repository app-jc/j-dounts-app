// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  @override
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phone,
    firstName,
    lastName,
    dateOfBirth,
    photo,
    totalPoints,
    notificationCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      ),
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final int id;
  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;
  final String? photo;
  final int totalPoints;
  final int notificationCount;
  const Member({
    required this.id,
    required this.phone,
    required this.firstName,
    this.lastName,
    required this.dateOfBirth,
    this.photo,
    required this.totalPoints,
    required this.notificationCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['phone'] = Variable<String>(phone);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    map['total_points'] = Variable<int>(totalPoints);
    map['notification_count'] = Variable<int>(notificationCount);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      phone: Value(phone),
      firstName: Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      dateOfBirth: Value(dateOfBirth),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
      totalPoints: Value(totalPoints),
      notificationCount: Value(notificationCount),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<int>(json['id']),
      phone: serializer.fromJson<String>(json['phone']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      photo: serializer.fromJson<String?>(json['photo']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      notificationCount: serializer.fromJson<int>(json['notificationCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'phone': serializer.toJson<String>(phone),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'photo': serializer.toJson<String?>(photo),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'notificationCount': serializer.toJson<int>(notificationCount),
    };
  }

  Member copyWith({
    int? id,
    String? phone,
    String? firstName,
    Value<String?> lastName = const Value.absent(),
    DateTime? dateOfBirth,
    Value<String?> photo = const Value.absent(),
    int? totalPoints,
    int? notificationCount,
  }) => Member(
    id: id ?? this.id,
    phone: phone ?? this.phone,
    firstName: firstName ?? this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    photo: photo.present ? photo.value : this.photo,
    totalPoints: totalPoints ?? this.totalPoints,
    notificationCount: notificationCount ?? this.notificationCount,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      phone: data.phone.present ? data.phone.value : this.phone,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      photo: data.photo.present ? data.photo.value : this.photo,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('photo: $photo, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('notificationCount: $notificationCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phone,
    firstName,
    lastName,
    dateOfBirth,
    photo,
    totalPoints,
    notificationCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.phone == this.phone &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.photo == this.photo &&
          other.totalPoints == this.totalPoints &&
          other.notificationCount == this.notificationCount);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<int> id;
  final Value<String> phone;
  final Value<String> firstName;
  final Value<String?> lastName;
  final Value<DateTime> dateOfBirth;
  final Value<String?> photo;
  final Value<int> totalPoints;
  final Value<int> notificationCount;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.phone = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.photo = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.notificationCount = const Value.absent(),
  });
  MembersCompanion.insert({
    this.id = const Value.absent(),
    required String phone,
    required String firstName,
    this.lastName = const Value.absent(),
    required DateTime dateOfBirth,
    this.photo = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.notificationCount = const Value.absent(),
  }) : phone = Value(phone),
       firstName = Value(firstName),
       dateOfBirth = Value(dateOfBirth);
  static Insertable<Member> custom({
    Expression<int>? id,
    Expression<String>? phone,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? photo,
    Expression<int>? totalPoints,
    Expression<int>? notificationCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phone != null) 'phone': phone,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (photo != null) 'photo': photo,
      if (totalPoints != null) 'total_points': totalPoints,
      if (notificationCount != null) 'notification_count': notificationCount,
    });
  }

  MembersCompanion copyWith({
    Value<int>? id,
    Value<String>? phone,
    Value<String>? firstName,
    Value<String?>? lastName,
    Value<DateTime>? dateOfBirth,
    Value<String?>? photo,
    Value<int>? totalPoints,
    Value<int>? notificationCount,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photo: photo ?? this.photo,
      totalPoints: totalPoints ?? this.totalPoints,
      notificationCount: notificationCount ?? this.notificationCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('photo: $photo, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('notificationCount: $notificationCount')
          ..write(')'))
        .toString();
  }
}

class $TiersTable extends Tiers with TableInfo<$TiersTable, Tier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TiersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thresholdMeta = const VerificationMeta(
    'threshold',
  );
  @override
  late final GeneratedColumn<int> threshold = GeneratedColumn<int>(
    'threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [name, threshold, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tiers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('threshold')) {
      context.handle(
        _thresholdMeta,
        threshold.isAcceptableOrUnknown(data['threshold']!, _thresholdMeta),
      );
    } else if (isInserting) {
      context.missing(_thresholdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Tier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tier(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      threshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}threshold'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $TiersTable createAlias(String alias) {
    return $TiersTable(attachedDatabase, alias);
  }
}

class Tier extends DataClass implements Insertable<Tier> {
  final String name;
  final int threshold;
  final int sortOrder;
  const Tier({
    required this.name,
    required this.threshold,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['threshold'] = Variable<int>(threshold);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  TiersCompanion toCompanion(bool nullToAbsent) {
    return TiersCompanion(
      name: Value(name),
      threshold: Value(threshold),
      sortOrder: Value(sortOrder),
    );
  }

  factory Tier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tier(
      name: serializer.fromJson<String>(json['name']),
      threshold: serializer.fromJson<int>(json['threshold']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'threshold': serializer.toJson<int>(threshold),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Tier copyWith({String? name, int? threshold, int? sortOrder}) => Tier(
    name: name ?? this.name,
    threshold: threshold ?? this.threshold,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Tier copyWithCompanion(TiersCompanion data) {
    return Tier(
      name: data.name.present ? data.name.value : this.name,
      threshold: data.threshold.present ? data.threshold.value : this.threshold,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tier(')
          ..write('name: $name, ')
          ..write('threshold: $threshold, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, threshold, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tier &&
          other.name == this.name &&
          other.threshold == this.threshold &&
          other.sortOrder == this.sortOrder);
}

class TiersCompanion extends UpdateCompanion<Tier> {
  final Value<String> name;
  final Value<int> threshold;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const TiersCompanion({
    this.name = const Value.absent(),
    this.threshold = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TiersCompanion.insert({
    required String name,
    required int threshold,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       threshold = Value(threshold),
       sortOrder = Value(sortOrder);
  static Insertable<Tier> custom({
    Expression<String>? name,
    Expression<int>? threshold,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (threshold != null) 'threshold': threshold,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TiersCompanion copyWith({
    Value<String>? name,
    Value<int>? threshold,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return TiersCompanion(
      name: name ?? this.name,
      threshold: threshold ?? this.threshold,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (threshold.present) {
      map['threshold'] = Variable<int>(threshold.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TiersCompanion(')
          ..write('name: $name, ')
          ..write('threshold: $threshold, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  @override
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _discountLabelMeta = const VerificationMeta(
    'discountLabel',
  );
  @override
  late final GeneratedColumn<String> discountLabel = GeneratedColumn<String>(
    'discount_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    name,
    priceMmk,
    isNew,
    discountLabel,
    description,
    image,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    }
    if (data.containsKey('discount_label')) {
      context.handle(
        _discountLabelMeta,
        discountLabel.isAcceptableOrUnknown(
          data['discount_label']!,
          _discountLabelMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discount_label'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String? discountLabel;
  final String description;
  final String image;
  const Product({
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountLabel,
    required this.description,
    required this.image,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountLabel != null) {
      map['discount_label'] = Variable<String>(discountLabel);
    }
    map['description'] = Variable<String>(description);
    map['image'] = Variable<String>(image);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountLabel: discountLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(discountLabel),
      description: Value(description),
      image: Value(image),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['priceMmk']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountLabel: serializer.fromJson<String?>(json['discountLabel']),
      description: serializer.fromJson<String>(json['description']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priceMmk': serializer.toJson<int>(priceMmk),
      'isNew': serializer.toJson<bool>(isNew),
      'discountLabel': serializer.toJson<String?>(discountLabel),
      'description': serializer.toJson<String>(description),
      'image': serializer.toJson<String>(image),
    };
  }

  Product copyWith({
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<String?> discountLabel = const Value.absent(),
    String? description,
    String? image,
  }) => Product(
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountLabel: discountLabel.present
        ? discountLabel.value
        : this.discountLabel,
    description: description ?? this.description,
    image: image ?? this.image,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountLabel: data.discountLabel.present
          ? data.discountLabel.value
          : this.discountLabel,
      description: data.description.present
          ? data.description.value
          : this.description,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountLabel: $discountLabel, ')
          ..write('description: $description, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    code,
    name,
    priceMmk,
    isNew,
    discountLabel,
    description,
    image,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountLabel == this.discountLabel &&
          other.description == this.description &&
          other.image == this.image);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<String?> discountLabel;
  final Value<String> description;
  final Value<String> image;
  final Value<int> rowid;
  const ProductsCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountLabel = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String code,
    required String name,
    required int priceMmk,
    this.isNew = const Value.absent(),
    this.discountLabel = const Value.absent(),
    required String description,
    required String image,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk),
       description = Value(description),
       image = Value(image);
  static Insertable<Product> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<String>? discountLabel,
    Expression<String>? description,
    Expression<String>? image,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountLabel != null) 'discount_label': discountLabel,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<String?>? discountLabel,
    Value<String>? description,
    Value<String>? image,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountLabel: discountLabel ?? this.discountLabel,
      description: description ?? this.description,
      image: image ?? this.image,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountLabel.present) {
      map['discount_label'] = Variable<String>(discountLabel.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountLabel: $discountLabel, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionsTable extends Sections with TableInfo<$SectionsTable, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layoutStyleMeta = const VerificationMeta(
    'layoutStyle',
  );
  @override
  late final GeneratedColumn<String> layoutStyle = GeneratedColumn<String>(
    'layout_style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _seeAllMeta = const VerificationMeta('seeAll');
  @override
  late final GeneratedColumn<bool> seeAll = GeneratedColumn<bool>(
    'see_all',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("see_all" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    type,
    layoutStyle,
    sortOrder,
    seeAll,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Section> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('layout_style')) {
      context.handle(
        _layoutStyleMeta,
        layoutStyle.isAcceptableOrUnknown(
          data['layout_style']!,
          _layoutStyleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_layoutStyleMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('see_all')) {
      context.handle(
        _seeAllMeta,
        seeAll.isAcceptableOrUnknown(data['see_all']!, _seeAllMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      layoutStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layout_style'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      seeAll: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}see_all'],
      )!,
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }
}

class Section extends DataClass implements Insertable<Section> {
  final String id;
  final String title;
  final String type;
  final String layoutStyle;
  final int sortOrder;
  final bool seeAll;
  const Section({
    required this.id,
    required this.title,
    required this.type,
    required this.layoutStyle,
    required this.sortOrder,
    required this.seeAll,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['layout_style'] = Variable<String>(layoutStyle);
    map['sort_order'] = Variable<int>(sortOrder);
    map['see_all'] = Variable<bool>(seeAll);
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      layoutStyle: Value(layoutStyle),
      sortOrder: Value(sortOrder),
      seeAll: Value(seeAll),
    );
  }

  factory Section.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      layoutStyle: serializer.fromJson<String>(json['layoutStyle']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      seeAll: serializer.fromJson<bool>(json['seeAll']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'layoutStyle': serializer.toJson<String>(layoutStyle),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'seeAll': serializer.toJson<bool>(seeAll),
    };
  }

  Section copyWith({
    String? id,
    String? title,
    String? type,
    String? layoutStyle,
    int? sortOrder,
    bool? seeAll,
  }) => Section(
    id: id ?? this.id,
    title: title ?? this.title,
    type: type ?? this.type,
    layoutStyle: layoutStyle ?? this.layoutStyle,
    sortOrder: sortOrder ?? this.sortOrder,
    seeAll: seeAll ?? this.seeAll,
  );
  Section copyWithCompanion(SectionsCompanion data) {
    return Section(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      layoutStyle: data.layoutStyle.present
          ? data.layoutStyle.value
          : this.layoutStyle,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      seeAll: data.seeAll.present ? data.seeAll.value : this.seeAll,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Section(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('layoutStyle: $layoutStyle, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('seeAll: $seeAll')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, type, layoutStyle, sortOrder, seeAll);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.layoutStyle == this.layoutStyle &&
          other.sortOrder == this.sortOrder &&
          other.seeAll == this.seeAll);
}

class SectionsCompanion extends UpdateCompanion<Section> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> type;
  final Value<String> layoutStyle;
  final Value<int> sortOrder;
  final Value<bool> seeAll;
  final Value<int> rowid;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.layoutStyle = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.seeAll = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionsCompanion.insert({
    required String id,
    required String title,
    required String type,
    required String layoutStyle,
    required int sortOrder,
    this.seeAll = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       type = Value(type),
       layoutStyle = Value(layoutStyle),
       sortOrder = Value(sortOrder);
  static Insertable<Section> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? layoutStyle,
    Expression<int>? sortOrder,
    Expression<bool>? seeAll,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (layoutStyle != null) 'layout_style': layoutStyle,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (seeAll != null) 'see_all': seeAll,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? type,
    Value<String>? layoutStyle,
    Value<int>? sortOrder,
    Value<bool>? seeAll,
    Value<int>? rowid,
  }) {
    return SectionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      layoutStyle: layoutStyle ?? this.layoutStyle,
      sortOrder: sortOrder ?? this.sortOrder,
      seeAll: seeAll ?? this.seeAll,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (layoutStyle.present) {
      map['layout_style'] = Variable<String>(layoutStyle.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (seeAll.present) {
      map['see_all'] = Variable<bool>(seeAll.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('layoutStyle: $layoutStyle, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('seeAll: $seeAll, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionProductsTable extends SectionProducts
    with TableInfo<$SectionProductsTable, SectionProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
    'section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sections (id)',
    ),
  );
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'product_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (code)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountOverrideMeta = const VerificationMeta(
    'discountOverride',
  );
  @override
  late final GeneratedColumn<String> discountOverride = GeneratedColumn<String>(
    'discount_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sectionId,
    productCode,
    sortOrder,
    discountOverride,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'section_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('product_code')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['product_code']!,
          _productCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('discount_override')) {
      context.handle(
        _discountOverrideMeta,
        discountOverride.isAcceptableOrUnknown(
          data['discount_override']!,
          _discountOverrideMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sectionId, productCode};
  @override
  SectionProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionProduct(
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      )!,
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_code'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      discountOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discount_override'],
      ),
    );
  }

  @override
  $SectionProductsTable createAlias(String alias) {
    return $SectionProductsTable(attachedDatabase, alias);
  }
}

class SectionProduct extends DataClass implements Insertable<SectionProduct> {
  final String sectionId;
  final String productCode;
  final int sortOrder;
  final String? discountOverride;
  const SectionProduct({
    required this.sectionId,
    required this.productCode,
    required this.sortOrder,
    this.discountOverride,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['section_id'] = Variable<String>(sectionId);
    map['product_code'] = Variable<String>(productCode);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || discountOverride != null) {
      map['discount_override'] = Variable<String>(discountOverride);
    }
    return map;
  }

  SectionProductsCompanion toCompanion(bool nullToAbsent) {
    return SectionProductsCompanion(
      sectionId: Value(sectionId),
      productCode: Value(productCode),
      sortOrder: Value(sortOrder),
      discountOverride: discountOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(discountOverride),
    );
  }

  factory SectionProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionProduct(
      sectionId: serializer.fromJson<String>(json['sectionId']),
      productCode: serializer.fromJson<String>(json['productCode']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      discountOverride: serializer.fromJson<String?>(json['discountOverride']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sectionId': serializer.toJson<String>(sectionId),
      'productCode': serializer.toJson<String>(productCode),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'discountOverride': serializer.toJson<String?>(discountOverride),
    };
  }

  SectionProduct copyWith({
    String? sectionId,
    String? productCode,
    int? sortOrder,
    Value<String?> discountOverride = const Value.absent(),
  }) => SectionProduct(
    sectionId: sectionId ?? this.sectionId,
    productCode: productCode ?? this.productCode,
    sortOrder: sortOrder ?? this.sortOrder,
    discountOverride: discountOverride.present
        ? discountOverride.value
        : this.discountOverride,
  );
  SectionProduct copyWithCompanion(SectionProductsCompanion data) {
    return SectionProduct(
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      discountOverride: data.discountOverride.present
          ? data.discountOverride.value
          : this.discountOverride,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionProduct(')
          ..write('sectionId: $sectionId, ')
          ..write('productCode: $productCode, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('discountOverride: $discountOverride')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(sectionId, productCode, sortOrder, discountOverride);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionProduct &&
          other.sectionId == this.sectionId &&
          other.productCode == this.productCode &&
          other.sortOrder == this.sortOrder &&
          other.discountOverride == this.discountOverride);
}

class SectionProductsCompanion extends UpdateCompanion<SectionProduct> {
  final Value<String> sectionId;
  final Value<String> productCode;
  final Value<int> sortOrder;
  final Value<String?> discountOverride;
  final Value<int> rowid;
  const SectionProductsCompanion({
    this.sectionId = const Value.absent(),
    this.productCode = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.discountOverride = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionProductsCompanion.insert({
    required String sectionId,
    required String productCode,
    required int sortOrder,
    this.discountOverride = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sectionId = Value(sectionId),
       productCode = Value(productCode),
       sortOrder = Value(sortOrder);
  static Insertable<SectionProduct> custom({
    Expression<String>? sectionId,
    Expression<String>? productCode,
    Expression<int>? sortOrder,
    Expression<String>? discountOverride,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sectionId != null) 'section_id': sectionId,
      if (productCode != null) 'product_code': productCode,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (discountOverride != null) 'discount_override': discountOverride,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionProductsCompanion copyWith({
    Value<String>? sectionId,
    Value<String>? productCode,
    Value<int>? sortOrder,
    Value<String?>? discountOverride,
    Value<int>? rowid,
  }) {
    return SectionProductsCompanion(
      sectionId: sectionId ?? this.sectionId,
      productCode: productCode ?? this.productCode,
      sortOrder: sortOrder ?? this.sortOrder,
      discountOverride: discountOverride ?? this.discountOverride,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (discountOverride.present) {
      map['discount_override'] = Variable<String>(discountOverride.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionProductsCompanion(')
          ..write('sectionId: $sectionId, ')
          ..write('productCode: $productCode, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('discountOverride: $discountOverride, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BannersTable extends Banners with TableInfo<$BannersTable, Banner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BannersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
    'target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, image, sortOrder, target];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<Banner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Banner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Banner(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target'],
      ),
    );
  }

  @override
  $BannersTable createAlias(String alias) {
    return $BannersTable(attachedDatabase, alias);
  }
}

class Banner extends DataClass implements Insertable<Banner> {
  final String id;
  final String title;
  final String image;
  final int sortOrder;
  final String? target;
  const Banner({
    required this.id,
    required this.title,
    required this.image,
    required this.sortOrder,
    this.target,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['image'] = Variable<String>(image);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || target != null) {
      map['target'] = Variable<String>(target);
    }
    return map;
  }

  BannersCompanion toCompanion(bool nullToAbsent) {
    return BannersCompanion(
      id: Value(id),
      title: Value(title),
      image: Value(image),
      sortOrder: Value(sortOrder),
      target: target == null && nullToAbsent
          ? const Value.absent()
          : Value(target),
    );
  }

  factory Banner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Banner(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      image: serializer.fromJson<String>(json['image']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      target: serializer.fromJson<String?>(json['target']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'image': serializer.toJson<String>(image),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'target': serializer.toJson<String?>(target),
    };
  }

  Banner copyWith({
    String? id,
    String? title,
    String? image,
    int? sortOrder,
    Value<String?> target = const Value.absent(),
  }) => Banner(
    id: id ?? this.id,
    title: title ?? this.title,
    image: image ?? this.image,
    sortOrder: sortOrder ?? this.sortOrder,
    target: target.present ? target.value : this.target,
  );
  Banner copyWithCompanion(BannersCompanion data) {
    return Banner(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      image: data.image.present ? data.image.value : this.image,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      target: data.target.present ? data.target.value : this.target,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Banner(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('target: $target')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, image, sortOrder, target);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Banner &&
          other.id == this.id &&
          other.title == this.title &&
          other.image == this.image &&
          other.sortOrder == this.sortOrder &&
          other.target == this.target);
}

class BannersCompanion extends UpdateCompanion<Banner> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> image;
  final Value<int> sortOrder;
  final Value<String?> target;
  final Value<int> rowid;
  const BannersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.target = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BannersCompanion.insert({
    required String id,
    required String title,
    required String image,
    required int sortOrder,
    this.target = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       image = Value(image),
       sortOrder = Value(sortOrder);
  static Insertable<Banner> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? image,
    Expression<int>? sortOrder,
    Expression<String>? target,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (image != null) 'image': image,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (target != null) 'target': target,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BannersCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? image,
    Value<int>? sortOrder,
    Value<String?>? target,
    Value<int>? rowid,
  }) {
    return BannersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      sortOrder: sortOrder ?? this.sortOrder,
      target: target ?? this.target,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BannersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('target: $target, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopsTable extends Shops with TableInfo<$ShopsTable, Shop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, photo, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

class Shop extends DataClass implements Insertable<Shop> {
  final String id;
  final String name;
  final String photo;
  final int sortOrder;
  const Shop({
    required this.id,
    required this.name,
    required this.photo,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['photo'] = Variable<String>(photo);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      name: Value(name),
      photo: Value(photo),
      sortOrder: Value(sortOrder),
    );
  }

  factory Shop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shop(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      photo: serializer.fromJson<String>(json['photo']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'photo': serializer.toJson<String>(photo),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Shop copyWith({String? id, String? name, String? photo, int? sortOrder}) =>
      Shop(
        id: id ?? this.id,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  Shop copyWithCompanion(ShopsCompanion data) {
    return Shop(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      photo: data.photo.present ? data.photo.value : this.photo,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shop(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photo: $photo, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, photo, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shop &&
          other.id == this.id &&
          other.name == this.name &&
          other.photo == this.photo &&
          other.sortOrder == this.sortOrder);
}

class ShopsCompanion extends UpdateCompanion<Shop> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> photo;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.photo = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    required String name,
    required String photo,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       photo = Value(photo),
       sortOrder = Value(sortOrder);
  static Insertable<Shop> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? photo,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (photo != null) 'photo': photo,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? photo,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photo: $photo, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengesTable extends Challenges
    with TableInfo<$ChallengesTable, Challenge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<int> goal = GeneratedColumn<int>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsRewardMeta = const VerificationMeta(
    'pointsReward',
  );
  @override
  late final GeneratedColumn<int> pointsReward = GeneratedColumn<int>(
    'points_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artworkTypeMeta = const VerificationMeta(
    'artworkType',
  );
  @override
  late final GeneratedColumn<String> artworkType = GeneratedColumn<String>(
    'artwork_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    goal,
    pointsReward,
    artworkType,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Challenge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('points_reward')) {
      context.handle(
        _pointsRewardMeta,
        pointsReward.isAcceptableOrUnknown(
          data['points_reward']!,
          _pointsRewardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointsRewardMeta);
    }
    if (data.containsKey('artwork_type')) {
      context.handle(
        _artworkTypeMeta,
        artworkType.isAcceptableOrUnknown(
          data['artwork_type']!,
          _artworkTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_artworkTypeMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Challenge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Challenge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal'],
      )!,
      pointsReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_reward'],
      )!,
      artworkType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_type'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ChallengesTable createAlias(String alias) {
    return $ChallengesTable(attachedDatabase, alias);
  }
}

class Challenge extends DataClass implements Insertable<Challenge> {
  final String id;
  final String title;
  final int goal;
  final int pointsReward;
  final String artworkType;
  final int sortOrder;
  const Challenge({
    required this.id,
    required this.title,
    required this.goal,
    required this.pointsReward,
    required this.artworkType,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['goal'] = Variable<int>(goal);
    map['points_reward'] = Variable<int>(pointsReward);
    map['artwork_type'] = Variable<String>(artworkType);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      title: Value(title),
      goal: Value(goal),
      pointsReward: Value(pointsReward),
      artworkType: Value(artworkType),
      sortOrder: Value(sortOrder),
    );
  }

  factory Challenge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Challenge(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      goal: serializer.fromJson<int>(json['goal']),
      pointsReward: serializer.fromJson<int>(json['pointsReward']),
      artworkType: serializer.fromJson<String>(json['artworkType']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'goal': serializer.toJson<int>(goal),
      'pointsReward': serializer.toJson<int>(pointsReward),
      'artworkType': serializer.toJson<String>(artworkType),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Challenge copyWith({
    String? id,
    String? title,
    int? goal,
    int? pointsReward,
    String? artworkType,
    int? sortOrder,
  }) => Challenge(
    id: id ?? this.id,
    title: title ?? this.title,
    goal: goal ?? this.goal,
    pointsReward: pointsReward ?? this.pointsReward,
    artworkType: artworkType ?? this.artworkType,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Challenge copyWithCompanion(ChallengesCompanion data) {
    return Challenge(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      goal: data.goal.present ? data.goal.value : this.goal,
      pointsReward: data.pointsReward.present
          ? data.pointsReward.value
          : this.pointsReward,
      artworkType: data.artworkType.present
          ? data.artworkType.value
          : this.artworkType,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Challenge(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('goal: $goal, ')
          ..write('pointsReward: $pointsReward, ')
          ..write('artworkType: $artworkType, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, goal, pointsReward, artworkType, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Challenge &&
          other.id == this.id &&
          other.title == this.title &&
          other.goal == this.goal &&
          other.pointsReward == this.pointsReward &&
          other.artworkType == this.artworkType &&
          other.sortOrder == this.sortOrder);
}

class ChallengesCompanion extends UpdateCompanion<Challenge> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> goal;
  final Value<int> pointsReward;
  final Value<String> artworkType;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.goal = const Value.absent(),
    this.pointsReward = const Value.absent(),
    this.artworkType = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String title,
    required int goal,
    required int pointsReward,
    required String artworkType,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       goal = Value(goal),
       pointsReward = Value(pointsReward),
       artworkType = Value(artworkType),
       sortOrder = Value(sortOrder);
  static Insertable<Challenge> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? goal,
    Expression<int>? pointsReward,
    Expression<String>? artworkType,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (goal != null) 'goal': goal,
      if (pointsReward != null) 'points_reward': pointsReward,
      if (artworkType != null) 'artwork_type': artworkType,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? goal,
    Value<int>? pointsReward,
    Value<String>? artworkType,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ChallengesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      goal: goal ?? this.goal,
      pointsReward: pointsReward ?? this.pointsReward,
      artworkType: artworkType ?? this.artworkType,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (goal.present) {
      map['goal'] = Variable<int>(goal.value);
    }
    if (pointsReward.present) {
      map['points_reward'] = Variable<int>(pointsReward.value);
    }
    if (artworkType.present) {
      map['artwork_type'] = Variable<String>(artworkType.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('goal: $goal, ')
          ..write('pointsReward: $pointsReward, ')
          ..write('artworkType: $artworkType, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MemberChallengeProgressTable extends MemberChallengeProgress
    with TableInfo<$MemberChallengeProgressTable, MemberChallengeProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemberChallengeProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<int> memberId = GeneratedColumn<int>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _challengeIdMeta = const VerificationMeta(
    'challengeId',
  );
  @override
  late final GeneratedColumn<String> challengeId = GeneratedColumn<String>(
    'challenge_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES challenges (id)',
    ),
  );
  static const VerificationMeta _currentMeta = const VerificationMeta(
    'current',
  );
  @override
  late final GeneratedColumn<int> current = GeneratedColumn<int>(
    'current',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [memberId, challengeId, current];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'member_challenge_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberChallengeProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('challenge_id')) {
      context.handle(
        _challengeIdMeta,
        challengeId.isAcceptableOrUnknown(
          data['challenge_id']!,
          _challengeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_challengeIdMeta);
    }
    if (data.containsKey('current')) {
      context.handle(
        _currentMeta,
        current.isAcceptableOrUnknown(data['current']!, _currentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {memberId, challengeId};
  @override
  MemberChallengeProgressData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberChallengeProgressData(
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_id'],
      )!,
      challengeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_id'],
      )!,
      current: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current'],
      )!,
    );
  }

  @override
  $MemberChallengeProgressTable createAlias(String alias) {
    return $MemberChallengeProgressTable(attachedDatabase, alias);
  }
}

class MemberChallengeProgressData extends DataClass
    implements Insertable<MemberChallengeProgressData> {
  final int memberId;
  final String challengeId;
  final int current;
  const MemberChallengeProgressData({
    required this.memberId,
    required this.challengeId,
    required this.current,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['member_id'] = Variable<int>(memberId);
    map['challenge_id'] = Variable<String>(challengeId);
    map['current'] = Variable<int>(current);
    return map;
  }

  MemberChallengeProgressCompanion toCompanion(bool nullToAbsent) {
    return MemberChallengeProgressCompanion(
      memberId: Value(memberId),
      challengeId: Value(challengeId),
      current: Value(current),
    );
  }

  factory MemberChallengeProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberChallengeProgressData(
      memberId: serializer.fromJson<int>(json['memberId']),
      challengeId: serializer.fromJson<String>(json['challengeId']),
      current: serializer.fromJson<int>(json['current']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'memberId': serializer.toJson<int>(memberId),
      'challengeId': serializer.toJson<String>(challengeId),
      'current': serializer.toJson<int>(current),
    };
  }

  MemberChallengeProgressData copyWith({
    int? memberId,
    String? challengeId,
    int? current,
  }) => MemberChallengeProgressData(
    memberId: memberId ?? this.memberId,
    challengeId: challengeId ?? this.challengeId,
    current: current ?? this.current,
  );
  MemberChallengeProgressData copyWithCompanion(
    MemberChallengeProgressCompanion data,
  ) {
    return MemberChallengeProgressData(
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      challengeId: data.challengeId.present
          ? data.challengeId.value
          : this.challengeId,
      current: data.current.present ? data.current.value : this.current,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberChallengeProgressData(')
          ..write('memberId: $memberId, ')
          ..write('challengeId: $challengeId, ')
          ..write('current: $current')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(memberId, challengeId, current);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberChallengeProgressData &&
          other.memberId == this.memberId &&
          other.challengeId == this.challengeId &&
          other.current == this.current);
}

class MemberChallengeProgressCompanion
    extends UpdateCompanion<MemberChallengeProgressData> {
  final Value<int> memberId;
  final Value<String> challengeId;
  final Value<int> current;
  final Value<int> rowid;
  const MemberChallengeProgressCompanion({
    this.memberId = const Value.absent(),
    this.challengeId = const Value.absent(),
    this.current = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemberChallengeProgressCompanion.insert({
    required int memberId,
    required String challengeId,
    this.current = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : memberId = Value(memberId),
       challengeId = Value(challengeId);
  static Insertable<MemberChallengeProgressData> custom({
    Expression<int>? memberId,
    Expression<String>? challengeId,
    Expression<int>? current,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (memberId != null) 'member_id': memberId,
      if (challengeId != null) 'challenge_id': challengeId,
      if (current != null) 'current': current,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemberChallengeProgressCompanion copyWith({
    Value<int>? memberId,
    Value<String>? challengeId,
    Value<int>? current,
    Value<int>? rowid,
  }) {
    return MemberChallengeProgressCompanion(
      memberId: memberId ?? this.memberId,
      challengeId: challengeId ?? this.challengeId,
      current: current ?? this.current,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (memberId.present) {
      map['member_id'] = Variable<int>(memberId.value);
    }
    if (challengeId.present) {
      map['challenge_id'] = Variable<String>(challengeId.value);
    }
    if (current.present) {
      map['current'] = Variable<int>(current.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemberChallengeProgressCompanion(')
          ..write('memberId: $memberId, ')
          ..write('challengeId: $challengeId, ')
          ..write('current: $current, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GiftsTable extends Gifts with TableInfo<$GiftsTable, Gift> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsCostMeta = const VerificationMeta(
    'pointsCost',
  );
  @override
  late final GeneratedColumn<int> pointsCost = GeneratedColumn<int>(
    'points_cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    pointsCost,
    image,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gift> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('points_cost')) {
      context.handle(
        _pointsCostMeta,
        pointsCost.isAcceptableOrUnknown(data['points_cost']!, _pointsCostMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsCostMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gift map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gift(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      pointsCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_cost'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $GiftsTable createAlias(String alias) {
    return $GiftsTable(attachedDatabase, alias);
  }
}

class Gift extends DataClass implements Insertable<Gift> {
  final String id;
  final String title;
  final int pointsCost;
  final String image;
  final int sortOrder;
  const Gift({
    required this.id,
    required this.title,
    required this.pointsCost,
    required this.image,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['points_cost'] = Variable<int>(pointsCost);
    map['image'] = Variable<String>(image);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  GiftsCompanion toCompanion(bool nullToAbsent) {
    return GiftsCompanion(
      id: Value(id),
      title: Value(title),
      pointsCost: Value(pointsCost),
      image: Value(image),
      sortOrder: Value(sortOrder),
    );
  }

  factory Gift.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gift(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      pointsCost: serializer.fromJson<int>(json['pointsCost']),
      image: serializer.fromJson<String>(json['image']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'pointsCost': serializer.toJson<int>(pointsCost),
      'image': serializer.toJson<String>(image),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Gift copyWith({
    String? id,
    String? title,
    int? pointsCost,
    String? image,
    int? sortOrder,
  }) => Gift(
    id: id ?? this.id,
    title: title ?? this.title,
    pointsCost: pointsCost ?? this.pointsCost,
    image: image ?? this.image,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Gift copyWithCompanion(GiftsCompanion data) {
    return Gift(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      pointsCost: data.pointsCost.present
          ? data.pointsCost.value
          : this.pointsCost,
      image: data.image.present ? data.image.value : this.image,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gift(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('pointsCost: $pointsCost, ')
          ..write('image: $image, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, pointsCost, image, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gift &&
          other.id == this.id &&
          other.title == this.title &&
          other.pointsCost == this.pointsCost &&
          other.image == this.image &&
          other.sortOrder == this.sortOrder);
}

class GiftsCompanion extends UpdateCompanion<Gift> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> pointsCost;
  final Value<String> image;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const GiftsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.pointsCost = const Value.absent(),
    this.image = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GiftsCompanion.insert({
    required String id,
    required String title,
    required int pointsCost,
    required String image,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       pointsCost = Value(pointsCost),
       image = Value(image),
       sortOrder = Value(sortOrder);
  static Insertable<Gift> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? pointsCost,
    Expression<String>? image,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (pointsCost != null) 'points_cost': pointsCost,
      if (image != null) 'image': image,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GiftsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? pointsCost,
    Value<String>? image,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return GiftsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      pointsCost: pointsCost ?? this.pointsCost,
      image: image ?? this.image,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (pointsCost.present) {
      map['points_cost'] = Variable<int>(pointsCost.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GiftsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('pointsCost: $pointsCost, ')
          ..write('image: $image, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeedStatesTable extends SeedStates
    with TableInfo<$SeedStatesTable, SeedState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeedStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSeededMeta = const VerificationMeta(
    'isSeeded',
  );
  @override
  late final GeneratedColumn<bool> isSeeded = GeneratedColumn<bool>(
    'is_seeded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_seeded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, isSeeded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seed_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeedState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_seeded')) {
      context.handle(
        _isSeededMeta,
        isSeeded.isAcceptableOrUnknown(data['is_seeded']!, _isSeededMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeedState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeedState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isSeeded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_seeded'],
      )!,
    );
  }

  @override
  $SeedStatesTable createAlias(String alias) {
    return $SeedStatesTable(attachedDatabase, alias);
  }
}

class SeedState extends DataClass implements Insertable<SeedState> {
  final int id;
  final bool isSeeded;
  const SeedState({required this.id, required this.isSeeded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_seeded'] = Variable<bool>(isSeeded);
    return map;
  }

  SeedStatesCompanion toCompanion(bool nullToAbsent) {
    return SeedStatesCompanion(id: Value(id), isSeeded: Value(isSeeded));
  }

  factory SeedState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeedState(
      id: serializer.fromJson<int>(json['id']),
      isSeeded: serializer.fromJson<bool>(json['isSeeded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isSeeded': serializer.toJson<bool>(isSeeded),
    };
  }

  SeedState copyWith({int? id, bool? isSeeded}) =>
      SeedState(id: id ?? this.id, isSeeded: isSeeded ?? this.isSeeded);
  SeedState copyWithCompanion(SeedStatesCompanion data) {
    return SeedState(
      id: data.id.present ? data.id.value : this.id,
      isSeeded: data.isSeeded.present ? data.isSeeded.value : this.isSeeded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeedState(')
          ..write('id: $id, ')
          ..write('isSeeded: $isSeeded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isSeeded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeedState &&
          other.id == this.id &&
          other.isSeeded == this.isSeeded);
}

class SeedStatesCompanion extends UpdateCompanion<SeedState> {
  final Value<int> id;
  final Value<bool> isSeeded;
  const SeedStatesCompanion({
    this.id = const Value.absent(),
    this.isSeeded = const Value.absent(),
  });
  SeedStatesCompanion.insert({
    this.id = const Value.absent(),
    this.isSeeded = const Value.absent(),
  });
  static Insertable<SeedState> custom({
    Expression<int>? id,
    Expression<bool>? isSeeded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isSeeded != null) 'is_seeded': isSeeded,
    });
  }

  SeedStatesCompanion copyWith({Value<int>? id, Value<bool>? isSeeded}) {
    return SeedStatesCompanion(
      id: id ?? this.id,
      isSeeded: isSeeded ?? this.isSeeded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isSeeded.present) {
      map['is_seeded'] = Variable<bool>(isSeeded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeedStatesCompanion(')
          ..write('id: $id, ')
          ..write('isSeeded: $isSeeded')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MembersTable members = $MembersTable(this);
  late final $TiersTable tiers = $TiersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $SectionProductsTable sectionProducts = $SectionProductsTable(
    this,
  );
  late final $BannersTable banners = $BannersTable(this);
  late final $ShopsTable shops = $ShopsTable(this);
  late final $ChallengesTable challenges = $ChallengesTable(this);
  late final $MemberChallengeProgressTable memberChallengeProgress =
      $MemberChallengeProgressTable(this);
  late final $GiftsTable gifts = $GiftsTable(this);
  late final $SeedStatesTable seedStates = $SeedStatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    members,
    tiers,
    products,
    sections,
    sectionProducts,
    banners,
    shops,
    challenges,
    memberChallengeProgress,
    gifts,
    seedStates,
  ];
}

typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  Value<int> id,
  required String phone,
  required String firstName,
  Value<String?> lastName,
  required DateTime dateOfBirth,
  Value<String?> photo,
  Value<int> totalPoints,
  Value<int> notificationCount,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<int> id,
  Value<String> phone,
  Value<String> firstName,
  Value<String?> lastName,
  Value<DateTime> dateOfBirth,
  Value<String?> photo,
  Value<int> totalPoints,
  Value<int> notificationCount,
});

final class $$MembersTableReferences
    extends BaseReferences<_$AppDatabase, $MembersTable, Member> {
  $$MembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $MemberChallengeProgressTable,
    List<MemberChallengeProgressData>
  >
  _memberChallengeProgressRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.memberChallengeProgress,
        aliasName: 'members__id__member_challenge_progress__member_id',
      );

  $$MemberChallengeProgressTableProcessedTableManager
  get memberChallengeProgressRefs {
    final manager = $$MemberChallengeProgressTableTableManager(
      $_db,
      $_db.memberChallengeProgress,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _memberChallengeProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> memberChallengeProgressRefs(
    Expression<bool> Function($$MemberChallengeProgressTableFilterComposer f) f,
  ) {
    final $$MemberChallengeProgressTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.memberChallengeProgress,
          getReferencedColumn: (t) => t.memberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MemberChallengeProgressTableFilterComposer(
                $db: $db,
                $table: $db.memberChallengeProgress,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );

  Expression<T> memberChallengeProgressRefs<T extends Object>(
    Expression<T> Function($$MemberChallengeProgressTableAnnotationComposer a)
    f,
  ) {
    final $$MemberChallengeProgressTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.memberChallengeProgress,
          getReferencedColumn: (t) => t.memberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MemberChallengeProgressTableAnnotationComposer(
                $db: $db,
                $table: $db.memberChallengeProgress,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          Member,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (Member, $$MembersTableReferences),
          Member,
          PrefetchHooks Function({bool memberChallengeProgressRefs})
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                photo: photo,
                totalPoints: totalPoints,
                notificationCount: notificationCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String phone,
                required String firstName,
                Value<String?> lastName = const Value.absent(),
                required DateTime dateOfBirth,
                Value<String?> photo = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                photo: photo,
                totalPoints: totalPoints,
                notificationCount: notificationCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembersTable, Member>(table),
                  $$MembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberChallengeProgressRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (memberChallengeProgressRefs) db.memberChallengeProgress,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (memberChallengeProgressRefs)
                    await $_getPrefetchedDataByColumns<
                      Member,
                      $MembersTable,
                      MemberChallengeProgressData,
                      $MemberChallengeProgressTable
                    >(
                      currentTable: table,
                      referencedTable: $$MembersTableReferences
                          ._memberChallengeProgressRefsTable(db),
                      managerFromTypedResult: (p0) => $$MembersTableReferences(
                        db,
                        table,
                        p0,
                      ).memberChallengeProgressRefs,
                      currentColumn: 'id',
                      referencedColumn: 'member_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      Member,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (Member, $$MembersTableReferences),
      Member,
      PrefetchHooks Function({bool memberChallengeProgressRefs})
    >;
typedef $$TiersTableCreateCompanionBuilder = TiersCompanion Function({
  required String name,
  required int threshold,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$TiersTableUpdateCompanionBuilder = TiersCompanion Function({
  Value<String> name,
  Value<int> threshold,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$TiersTableFilterComposer extends Composer<_$AppDatabase, $TiersTable> {
  $$TiersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get threshold => $composableBuilder(
    column: $table.threshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TiersTableOrderingComposer
    extends Composer<_$AppDatabase, $TiersTable> {
  $$TiersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get threshold => $composableBuilder(
    column: $table.threshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TiersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TiersTable> {
  $$TiersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get threshold =>
      $composableBuilder(column: $table.threshold, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$TiersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TiersTable,
          Tier,
          $$TiersTableFilterComposer,
          $$TiersTableOrderingComposer,
          $$TiersTableAnnotationComposer,
          $$TiersTableCreateCompanionBuilder,
          $$TiersTableUpdateCompanionBuilder,
          (Tier, BaseReferences<_$AppDatabase, $TiersTable, Tier>),
          Tier,
          PrefetchHooks Function()
        > {
  $$TiersTableTableManager(_$AppDatabase db, $TiersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TiersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TiersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TiersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<int> threshold = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TiersCompanion(
                name: name,
                threshold: threshold,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String name,
                required int threshold,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => TiersCompanion.insert(
                name: name,
                threshold: threshold,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TiersTable, Tier>(table),
                  BaseReferences<_$AppDatabase, $TiersTable, Tier>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TiersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TiersTable,
      Tier,
      $$TiersTableFilterComposer,
      $$TiersTableOrderingComposer,
      $$TiersTableAnnotationComposer,
      $$TiersTableCreateCompanionBuilder,
      $$TiersTableUpdateCompanionBuilder,
      (Tier, BaseReferences<_$AppDatabase, $TiersTable, Tier>),
      Tier,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String code,
  required String name,
  required int priceMmk,
  Value<bool> isNew,
  Value<String?> discountLabel,
  required String description,
  required String image,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> code,
  Value<String> name,
  Value<int> priceMmk,
  Value<bool> isNew,
  Value<String?> discountLabel,
  Value<String> description,
  Value<String> image,
  Value<int> rowid,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SectionProductsTable, List<SectionProduct>>
  _sectionProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionProducts,
    aliasName: 'products__code__section_products__product_code',
  );

  $$SectionProductsTableProcessedTableManager get sectionProductsRefs {
    final manager =
        $$SectionProductsTableTableManager($_db, $_db.sectionProducts).filter(
          (f) => f.productCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discountLabel => $composableBuilder(
    column: $table.discountLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsRefs(
    Expression<bool> Function($$SectionProductsTableFilterComposer f) f,
  ) {
    final $$SectionProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.productCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableFilterComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discountLabel => $composableBuilder(
    column: $table.discountLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<String> get discountLabel => $composableBuilder(
    column: $table.discountLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  Expression<T> sectionProductsRefs<T extends Object>(
    Expression<T> Function($$SectionProductsTableAnnotationComposer a) f,
  ) {
    final $$SectionProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.productCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool sectionProductsRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<String?> discountLabel = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountLabel: discountLabel,
                description: description,
                image: image,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String name,
                required int priceMmk,
                Value<bool> isNew = const Value.absent(),
                Value<String?> discountLabel = const Value.absent(),
                required String description,
                required String image,
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountLabel: discountLabel,
                description: description,
                image: image,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, Product>(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsRefs) db.sectionProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      Product,
                      $ProductsTable,
                      SectionProduct,
                      $SectionProductsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences
                          ._sectionProductsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(
                        db,
                        table,
                        p0,
                      ).sectionProductsRefs,
                      currentColumn: 'code',
                      referencedColumn: 'product_code',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool sectionProductsRefs})
    >;
typedef $$SectionsTableCreateCompanionBuilder = SectionsCompanion Function({
  required String id,
  required String title,
  required String type,
  required String layoutStyle,
  required int sortOrder,
  Value<bool> seeAll,
  Value<int> rowid,
});
typedef $$SectionsTableUpdateCompanionBuilder = SectionsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> type,
  Value<String> layoutStyle,
  Value<int> sortOrder,
  Value<bool> seeAll,
  Value<int> rowid,
});

final class $$SectionsTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTable, Section> {
  $$SectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SectionProductsTable, List<SectionProduct>>
  _sectionProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionProducts,
    aliasName: 'sections__id__section_products__section_id',
  );

  $$SectionProductsTableProcessedTableManager get sectionProductsRefs {
    final manager = $$SectionProductsTableTableManager(
      $_db,
      $_db.sectionProducts,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layoutStyle => $composableBuilder(
    column: $table.layoutStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get seeAll => $composableBuilder(
    column: $table.seeAll,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsRefs(
    Expression<bool> Function($$SectionProductsTableFilterComposer f) f,
  ) {
    final $$SectionProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableFilterComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layoutStyle => $composableBuilder(
    column: $table.layoutStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get seeAll => $composableBuilder(
    column: $table.seeAll,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get layoutStyle => $composableBuilder(
    column: $table.layoutStyle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get seeAll =>
      $composableBuilder(column: $table.seeAll, builder: (column) => column);

  Expression<T> sectionProductsRefs<T extends Object>(
    Expression<T> Function($$SectionProductsTableAnnotationComposer a) f,
  ) {
    final $$SectionProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProducts,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionsTable,
          Section,
          $$SectionsTableFilterComposer,
          $$SectionsTableOrderingComposer,
          $$SectionsTableAnnotationComposer,
          $$SectionsTableCreateCompanionBuilder,
          $$SectionsTableUpdateCompanionBuilder,
          (Section, $$SectionsTableReferences),
          Section,
          PrefetchHooks Function({bool sectionProductsRefs})
        > {
  $$SectionsTableTableManager(_$AppDatabase db, $SectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> layoutStyle = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> seeAll = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionsCompanion(
                id: id,
                title: title,
                type: type,
                layoutStyle: layoutStyle,
                sortOrder: sortOrder,
                seeAll: seeAll,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String type,
                required String layoutStyle,
                required int sortOrder,
                Value<bool> seeAll = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionsCompanion.insert(
                id: id,
                title: title,
                type: type,
                layoutStyle: layoutStyle,
                sortOrder: sortOrder,
                seeAll: seeAll,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SectionsTable, Section>(table),
                  $$SectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsRefs) db.sectionProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      Section,
                      $SectionsTable,
                      SectionProduct,
                      $SectionProductsTable
                    >(
                      currentTable: table,
                      referencedTable: $$SectionsTableReferences
                          ._sectionProductsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SectionsTableReferences(
                        db,
                        table,
                        p0,
                      ).sectionProductsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'section_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionsTable,
      Section,
      $$SectionsTableFilterComposer,
      $$SectionsTableOrderingComposer,
      $$SectionsTableAnnotationComposer,
      $$SectionsTableCreateCompanionBuilder,
      $$SectionsTableUpdateCompanionBuilder,
      (Section, $$SectionsTableReferences),
      Section,
      PrefetchHooks Function({bool sectionProductsRefs})
    >;
typedef $$SectionProductsTableCreateCompanionBuilder =
    SectionProductsCompanion Function({
      required String sectionId,
      required String productCode,
      required int sortOrder,
      Value<String?> discountOverride,
      Value<int> rowid,
    });
typedef $$SectionProductsTableUpdateCompanionBuilder =
    SectionProductsCompanion Function({
      Value<String> sectionId,
      Value<String> productCode,
      Value<int> sortOrder,
      Value<String?> discountOverride,
      Value<int> rowid,
    });

final class $$SectionProductsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SectionProductsTable, SectionProduct> {
  $$SectionProductsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('section_products__section_id__sections__id');

  $$SectionsTableProcessedTableManager get sectionId {
    final $_column = $_itemColumn<String>('section_id')!;

    final manager = $$SectionsTableTableManager(
      $_db,
      $_db.sections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productCodeTable(_$AppDatabase db) =>
      db.products.createAlias('section_products__product_code__products__code');

  $$ProductsTableProcessedTableManager get productCode {
    final $_column = $_itemColumn<String>('product_code')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SectionProductsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionProductsTable> {
  $$SectionProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discountOverride => $composableBuilder(
    column: $table.discountOverride,
    builder: (column) => ColumnFilters(column),
  );

  $$SectionsTableFilterComposer get sectionId {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableFilterComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productCode {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productCode,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionProductsTable> {
  $$SectionProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discountOverride => $composableBuilder(
    column: $table.discountOverride,
    builder: (column) => ColumnOrderings(column),
  );

  $$SectionsTableOrderingComposer get sectionId {
    final $$SectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableOrderingComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productCode {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productCode,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionProductsTable> {
  $$SectionProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get discountOverride => $composableBuilder(
    column: $table.discountOverride,
    builder: (column) => column,
  );

  $$SectionsTableAnnotationComposer get sectionId {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productCode {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productCode,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionProductsTable,
          SectionProduct,
          $$SectionProductsTableFilterComposer,
          $$SectionProductsTableOrderingComposer,
          $$SectionProductsTableAnnotationComposer,
          $$SectionProductsTableCreateCompanionBuilder,
          $$SectionProductsTableUpdateCompanionBuilder,
          (SectionProduct, $$SectionProductsTableReferences),
          SectionProduct,
          PrefetchHooks Function({bool sectionId, bool productCode})
        > {
  $$SectionProductsTableTableManager(
    _$AppDatabase db,
    $SectionProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sectionId = const Value.absent(),
                Value<String> productCode = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> discountOverride = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsCompanion(
                sectionId: sectionId,
                productCode: productCode,
                sortOrder: sortOrder,
                discountOverride: discountOverride,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sectionId,
                required String productCode,
                required int sortOrder,
                Value<String?> discountOverride = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsCompanion.insert(
                sectionId: sectionId,
                productCode: productCode,
                sortOrder: sortOrder,
                discountOverride: discountOverride,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SectionProductsTable, SectionProduct>(table),
                  $$SectionProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionId = false, productCode = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sectionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sectionId,
                        referencedTable: $$SectionProductsTableReferences
                            ._sectionIdTable(db),
                        referencedColumn: $$SectionProductsTableReferences
                            ._sectionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productCode) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productCode,
                        referencedTable: $$SectionProductsTableReferences
                            ._productCodeTable(db),
                        referencedColumn: $$SectionProductsTableReferences
                            ._productCodeTable(db)
                            .code,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SectionProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionProductsTable,
      SectionProduct,
      $$SectionProductsTableFilterComposer,
      $$SectionProductsTableOrderingComposer,
      $$SectionProductsTableAnnotationComposer,
      $$SectionProductsTableCreateCompanionBuilder,
      $$SectionProductsTableUpdateCompanionBuilder,
      (SectionProduct, $$SectionProductsTableReferences),
      SectionProduct,
      PrefetchHooks Function({bool sectionId, bool productCode})
    >;
typedef $$BannersTableCreateCompanionBuilder = BannersCompanion Function({
  required String id,
  required String title,
  required String image,
  required int sortOrder,
  Value<String?> target,
  Value<int> rowid,
});
typedef $$BannersTableUpdateCompanionBuilder = BannersCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> image,
  Value<int> sortOrder,
  Value<String?> target,
  Value<int> rowid,
});

class $$BannersTableFilterComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BannersTableOrderingComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BannersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);
}

class $$BannersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BannersTable,
          Banner,
          $$BannersTableFilterComposer,
          $$BannersTableOrderingComposer,
          $$BannersTableAnnotationComposer,
          $$BannersTableCreateCompanionBuilder,
          $$BannersTableUpdateCompanionBuilder,
          (Banner, BaseReferences<_$AppDatabase, $BannersTable, Banner>),
          Banner,
          PrefetchHooks Function()
        > {
  $$BannersTableTableManager(_$AppDatabase db, $BannersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BannersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BannersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BannersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> target = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion(
                id: id,
                title: title,
                image: image,
                sortOrder: sortOrder,
                target: target,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String image,
                required int sortOrder,
                Value<String?> target = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersCompanion.insert(
                id: id,
                title: title,
                image: image,
                sortOrder: sortOrder,
                target: target,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BannersTable, Banner>(table),
                  BaseReferences<_$AppDatabase, $BannersTable, Banner>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BannersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BannersTable,
      Banner,
      $$BannersTableFilterComposer,
      $$BannersTableOrderingComposer,
      $$BannersTableAnnotationComposer,
      $$BannersTableCreateCompanionBuilder,
      $$BannersTableUpdateCompanionBuilder,
      (Banner, BaseReferences<_$AppDatabase, $BannersTable, Banner>),
      Banner,
      PrefetchHooks Function()
    >;
typedef $$ShopsTableCreateCompanionBuilder = ShopsCompanion Function({
  required String id,
  required String name,
  required String photo,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$ShopsTableUpdateCompanionBuilder = ShopsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> photo,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$ShopsTableFilterComposer extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTable,
          Shop,
          $$ShopsTableFilterComposer,
          $$ShopsTableOrderingComposer,
          $$ShopsTableAnnotationComposer,
          $$ShopsTableCreateCompanionBuilder,
          $$ShopsTableUpdateCompanionBuilder,
          (Shop, BaseReferences<_$AppDatabase, $ShopsTable, Shop>),
          Shop,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableManager(_$AppDatabase db, $ShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> photo = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion(
                id: id,
                name: name,
                photo: photo,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String photo,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => ShopsCompanion.insert(
                id: id,
                name: name,
                photo: photo,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopsTable, Shop>(table),
                  BaseReferences<_$AppDatabase, $ShopsTable, Shop>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTable,
      Shop,
      $$ShopsTableFilterComposer,
      $$ShopsTableOrderingComposer,
      $$ShopsTableAnnotationComposer,
      $$ShopsTableCreateCompanionBuilder,
      $$ShopsTableUpdateCompanionBuilder,
      (Shop, BaseReferences<_$AppDatabase, $ShopsTable, Shop>),
      Shop,
      PrefetchHooks Function()
    >;
typedef $$ChallengesTableCreateCompanionBuilder = ChallengesCompanion Function({
  required String id,
  required String title,
  required int goal,
  required int pointsReward,
  required String artworkType,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$ChallengesTableUpdateCompanionBuilder = ChallengesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> goal,
  Value<int> pointsReward,
  Value<String> artworkType,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$ChallengesTableReferences
    extends BaseReferences<_$AppDatabase, $ChallengesTable, Challenge> {
  $$ChallengesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $MemberChallengeProgressTable,
    List<MemberChallengeProgressData>
  >
  _memberChallengeProgressRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.memberChallengeProgress,
        aliasName: 'challenges__id__member_challenge_progress__challenge_id',
      );

  $$MemberChallengeProgressTableProcessedTableManager
  get memberChallengeProgressRefs {
    final manager = $$MemberChallengeProgressTableTableManager(
      $_db,
      $_db.memberChallengeProgress,
    ).filter((f) => f.challengeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _memberChallengeProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsReward => $composableBuilder(
    column: $table.pointsReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkType => $composableBuilder(
    column: $table.artworkType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> memberChallengeProgressRefs(
    Expression<bool> Function($$MemberChallengeProgressTableFilterComposer f) f,
  ) {
    final $$MemberChallengeProgressTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.memberChallengeProgress,
          getReferencedColumn: (t) => t.challengeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MemberChallengeProgressTableFilterComposer(
                $db: $db,
                $table: $db.memberChallengeProgress,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsReward => $composableBuilder(
    column: $table.pointsReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkType => $composableBuilder(
    column: $table.artworkType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<int> get pointsReward => $composableBuilder(
    column: $table.pointsReward,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artworkType => $composableBuilder(
    column: $table.artworkType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> memberChallengeProgressRefs<T extends Object>(
    Expression<T> Function($$MemberChallengeProgressTableAnnotationComposer a)
    f,
  ) {
    final $$MemberChallengeProgressTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.memberChallengeProgress,
          getReferencedColumn: (t) => t.challengeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MemberChallengeProgressTableAnnotationComposer(
                $db: $db,
                $table: $db.memberChallengeProgress,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengesTable,
          Challenge,
          $$ChallengesTableFilterComposer,
          $$ChallengesTableOrderingComposer,
          $$ChallengesTableAnnotationComposer,
          $$ChallengesTableCreateCompanionBuilder,
          $$ChallengesTableUpdateCompanionBuilder,
          (Challenge, $$ChallengesTableReferences),
          Challenge,
          PrefetchHooks Function({bool memberChallengeProgressRefs})
        > {
  $$ChallengesTableTableManager(_$AppDatabase db, $ChallengesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> goal = const Value.absent(),
                Value<int> pointsReward = const Value.absent(),
                Value<String> artworkType = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion(
                id: id,
                title: title,
                goal: goal,
                pointsReward: pointsReward,
                artworkType: artworkType,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int goal,
                required int pointsReward,
                required String artworkType,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion.insert(
                id: id,
                title: title,
                goal: goal,
                pointsReward: pointsReward,
                artworkType: artworkType,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChallengesTable, Challenge>(table),
                  $$ChallengesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberChallengeProgressRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (memberChallengeProgressRefs) db.memberChallengeProgress,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (memberChallengeProgressRefs)
                    await $_getPrefetchedDataByColumns<
                      Challenge,
                      $ChallengesTable,
                      MemberChallengeProgressData,
                      $MemberChallengeProgressTable
                    >(
                      currentTable: table,
                      referencedTable: $$ChallengesTableReferences
                          ._memberChallengeProgressRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChallengesTableReferences(
                            db,
                            table,
                            p0,
                          ).memberChallengeProgressRefs,
                      currentColumn: 'id',
                      referencedColumn: 'challenge_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengesTable,
      Challenge,
      $$ChallengesTableFilterComposer,
      $$ChallengesTableOrderingComposer,
      $$ChallengesTableAnnotationComposer,
      $$ChallengesTableCreateCompanionBuilder,
      $$ChallengesTableUpdateCompanionBuilder,
      (Challenge, $$ChallengesTableReferences),
      Challenge,
      PrefetchHooks Function({bool memberChallengeProgressRefs})
    >;
typedef $$MemberChallengeProgressTableCreateCompanionBuilder =
    MemberChallengeProgressCompanion Function({
      required int memberId,
      required String challengeId,
      Value<int> current,
      Value<int> rowid,
    });
typedef $$MemberChallengeProgressTableUpdateCompanionBuilder =
    MemberChallengeProgressCompanion Function({
      Value<int> memberId,
      Value<String> challengeId,
      Value<int> current,
      Value<int> rowid,
    });

final class $$MemberChallengeProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MemberChallengeProgressTable,
          MemberChallengeProgressData
        > {
  $$MemberChallengeProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MembersTable _memberIdTable(_$AppDatabase db) => db.members
      .createAlias('member_challenge_progress__member_id__members__id');

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<int>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChallengesTable _challengeIdTable(_$AppDatabase db) => db.challenges
      .createAlias('member_challenge_progress__challenge_id__challenges__id');

  $$ChallengesTableProcessedTableManager get challengeId {
    final $_column = $_itemColumn<String>('challenge_id')!;

    final manager = $$ChallengesTableTableManager(
      $_db,
      $_db.challenges,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_challengeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MemberChallengeProgressTableFilterComposer
    extends Composer<_$AppDatabase, $MemberChallengeProgressTable> {
  $$MemberChallengeProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChallengesTableFilterComposer get challengeId {
    final $$ChallengesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.challengeId,
      referencedTable: $db.challenges,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChallengesTableFilterComposer(
            $db: $db,
            $table: $db.challenges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemberChallengeProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $MemberChallengeProgressTable> {
  $$MemberChallengeProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChallengesTableOrderingComposer get challengeId {
    final $$ChallengesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.challengeId,
      referencedTable: $db.challenges,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChallengesTableOrderingComposer(
            $db: $db,
            $table: $db.challenges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemberChallengeProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemberChallengeProgressTable> {
  $$MemberChallengeProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get current =>
      $composableBuilder(column: $table.current, builder: (column) => column);

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChallengesTableAnnotationComposer get challengeId {
    final $$ChallengesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.challengeId,
      referencedTable: $db.challenges,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChallengesTableAnnotationComposer(
            $db: $db,
            $table: $db.challenges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemberChallengeProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemberChallengeProgressTable,
          MemberChallengeProgressData,
          $$MemberChallengeProgressTableFilterComposer,
          $$MemberChallengeProgressTableOrderingComposer,
          $$MemberChallengeProgressTableAnnotationComposer,
          $$MemberChallengeProgressTableCreateCompanionBuilder,
          $$MemberChallengeProgressTableUpdateCompanionBuilder,
          (
            MemberChallengeProgressData,
            $$MemberChallengeProgressTableReferences,
          ),
          MemberChallengeProgressData,
          PrefetchHooks Function({bool memberId, bool challengeId})
        > {
  $$MemberChallengeProgressTableTableManager(
    _$AppDatabase db,
    $MemberChallengeProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemberChallengeProgressTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MemberChallengeProgressTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MemberChallengeProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> memberId = const Value.absent(),
                Value<String> challengeId = const Value.absent(),
                Value<int> current = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemberChallengeProgressCompanion(
                memberId: memberId,
                challengeId: challengeId,
                current: current,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int memberId,
                required String challengeId,
                Value<int> current = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemberChallengeProgressCompanion.insert(
                memberId: memberId,
                challengeId: challengeId,
                current: current,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $MemberChallengeProgressTable,
                    MemberChallengeProgressData
                  >(table),
                  $$MemberChallengeProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberId = false, challengeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (memberId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.memberId,
                        referencedTable:
                            $$MemberChallengeProgressTableReferences
                                ._memberIdTable(db),
                        referencedColumn:
                            $$MemberChallengeProgressTableReferences
                                ._memberIdTable(db)
                                .id,
                      ) as T;
                    }
                    if (challengeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.challengeId,
                        referencedTable:
                            $$MemberChallengeProgressTableReferences
                                ._challengeIdTable(db),
                        referencedColumn:
                            $$MemberChallengeProgressTableReferences
                                ._challengeIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MemberChallengeProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemberChallengeProgressTable,
      MemberChallengeProgressData,
      $$MemberChallengeProgressTableFilterComposer,
      $$MemberChallengeProgressTableOrderingComposer,
      $$MemberChallengeProgressTableAnnotationComposer,
      $$MemberChallengeProgressTableCreateCompanionBuilder,
      $$MemberChallengeProgressTableUpdateCompanionBuilder,
      (MemberChallengeProgressData, $$MemberChallengeProgressTableReferences),
      MemberChallengeProgressData,
      PrefetchHooks Function({bool memberId, bool challengeId})
    >;
typedef $$GiftsTableCreateCompanionBuilder = GiftsCompanion Function({
  required String id,
  required String title,
  required int pointsCost,
  required String image,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$GiftsTableUpdateCompanionBuilder = GiftsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> pointsCost,
  Value<String> image,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$GiftsTableFilterComposer extends Composer<_$AppDatabase, $GiftsTable> {
  $$GiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsCost => $composableBuilder(
    column: $table.pointsCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $GiftsTable> {
  $$GiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsCost => $composableBuilder(
    column: $table.pointsCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GiftsTable> {
  $$GiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get pointsCost => $composableBuilder(
    column: $table.pointsCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$GiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GiftsTable,
          Gift,
          $$GiftsTableFilterComposer,
          $$GiftsTableOrderingComposer,
          $$GiftsTableAnnotationComposer,
          $$GiftsTableCreateCompanionBuilder,
          $$GiftsTableUpdateCompanionBuilder,
          (Gift, BaseReferences<_$AppDatabase, $GiftsTable, Gift>),
          Gift,
          PrefetchHooks Function()
        > {
  $$GiftsTableTableManager(_$AppDatabase db, $GiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> pointsCost = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GiftsCompanion(
                id: id,
                title: title,
                pointsCost: pointsCost,
                image: image,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int pointsCost,
                required String image,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => GiftsCompanion.insert(
                id: id,
                title: title,
                pointsCost: pointsCost,
                image: image,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GiftsTable, Gift>(table),
                  BaseReferences<_$AppDatabase, $GiftsTable, Gift>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GiftsTable,
      Gift,
      $$GiftsTableFilterComposer,
      $$GiftsTableOrderingComposer,
      $$GiftsTableAnnotationComposer,
      $$GiftsTableCreateCompanionBuilder,
      $$GiftsTableUpdateCompanionBuilder,
      (Gift, BaseReferences<_$AppDatabase, $GiftsTable, Gift>),
      Gift,
      PrefetchHooks Function()
    >;
typedef $$SeedStatesTableCreateCompanionBuilder = SeedStatesCompanion Function({
  Value<int> id,
  Value<bool> isSeeded,
});
typedef $$SeedStatesTableUpdateCompanionBuilder = SeedStatesCompanion Function({
  Value<int> id,
  Value<bool> isSeeded,
});

class $$SeedStatesTableFilterComposer
    extends Composer<_$AppDatabase, $SeedStatesTable> {
  $$SeedStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSeeded => $composableBuilder(
    column: $table.isSeeded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SeedStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SeedStatesTable> {
  $$SeedStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSeeded => $composableBuilder(
    column: $table.isSeeded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SeedStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeedStatesTable> {
  $$SeedStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isSeeded =>
      $composableBuilder(column: $table.isSeeded, builder: (column) => column);
}

class $$SeedStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeedStatesTable,
          SeedState,
          $$SeedStatesTableFilterComposer,
          $$SeedStatesTableOrderingComposer,
          $$SeedStatesTableAnnotationComposer,
          $$SeedStatesTableCreateCompanionBuilder,
          $$SeedStatesTableUpdateCompanionBuilder,
          (
            SeedState,
            BaseReferences<_$AppDatabase, $SeedStatesTable, SeedState>,
          ),
          SeedState,
          PrefetchHooks Function()
        > {
  $$SeedStatesTableTableManager(_$AppDatabase db, $SeedStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeedStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeedStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeedStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isSeeded = const Value.absent(),
          }) => SeedStatesCompanion(id: id, isSeeded: isSeeded),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isSeeded = const Value.absent(),
          }) => SeedStatesCompanion.insert(id: id, isSeeded: isSeeded),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SeedStatesTable, SeedState>(table),
                  BaseReferences<_$AppDatabase, $SeedStatesTable, SeedState>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SeedStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeedStatesTable,
      SeedState,
      $$SeedStatesTableFilterComposer,
      $$SeedStatesTableOrderingComposer,
      $$SeedStatesTableAnnotationComposer,
      $$SeedStatesTableCreateCompanionBuilder,
      $$SeedStatesTableUpdateCompanionBuilder,
      (SeedState, BaseReferences<_$AppDatabase, $SeedStatesTable, SeedState>),
      SeedState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$TiersTableTableManager get tiers =>
      $$TiersTableTableManager(_db, _db.tiers);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db, _db.sections);
  $$SectionProductsTableTableManager get sectionProducts =>
      $$SectionProductsTableTableManager(_db, _db.sectionProducts);
  $$BannersTableTableManager get banners =>
      $$BannersTableTableManager(_db, _db.banners);
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db, _db.shops);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db, _db.challenges);
  $$MemberChallengeProgressTableTableManager get memberChallengeProgress =>
      $$MemberChallengeProgressTableTableManager(
        _db,
        _db.memberChallengeProgress,
      );
  $$GiftsTableTableManager get gifts =>
      $$GiftsTableTableManager(_db, _db.gifts);
  $$SeedStatesTableTableManager get seedStates =>
      $$SeedStatesTableTableManager(_db, _db.seedStates);
}
