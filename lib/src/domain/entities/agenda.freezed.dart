// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Agenda {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get dateTime => throw _privateConstructorUsedError;
  List<int>? get imagePath => throw _privateConstructorUsedError;
  String? get imageName => throw _privateConstructorUsedError;
  String? get timeReminder => throw _privateConstructorUsedError;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgendaCopyWith<Agenda> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaCopyWith<$Res> {
  factory $AgendaCopyWith(Agenda value, $Res Function(Agenda) then) =
      _$AgendaCopyWithImpl<$Res, Agenda>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      String? dateTime,
      List<int>? imagePath,
      String? imageName,
      String? timeReminder});
}

/// @nodoc
class _$AgendaCopyWithImpl<$Res, $Val extends Agenda>
    implements $AgendaCopyWith<$Res> {
  _$AgendaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dateTime = freezed,
    Object? imagePath = freezed,
    Object? imageName = freezed,
    Object? timeReminder = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      imageName: freezed == imageName
          ? _value.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String?,
      timeReminder: freezed == timeReminder
          ? _value.timeReminder
          : timeReminder // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaImplCopyWith<$Res> implements $AgendaCopyWith<$Res> {
  factory _$$AgendaImplCopyWith(
          _$AgendaImpl value, $Res Function(_$AgendaImpl) then) =
      __$$AgendaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      String? dateTime,
      List<int>? imagePath,
      String? imageName,
      String? timeReminder});
}

/// @nodoc
class __$$AgendaImplCopyWithImpl<$Res>
    extends _$AgendaCopyWithImpl<$Res, _$AgendaImpl>
    implements _$$AgendaImplCopyWith<$Res> {
  __$$AgendaImplCopyWithImpl(
      _$AgendaImpl _value, $Res Function(_$AgendaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dateTime = freezed,
    Object? imagePath = freezed,
    Object? imageName = freezed,
    Object? timeReminder = freezed,
  }) {
    return _then(_$AgendaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value._imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      imageName: freezed == imageName
          ? _value.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String?,
      timeReminder: freezed == timeReminder
          ? _value.timeReminder
          : timeReminder // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AgendaImpl implements _Agenda {
  const _$AgendaImpl(
      {this.id,
      this.title,
      this.description,
      this.dateTime,
      final List<int>? imagePath,
      this.imageName,
      this.timeReminder})
      : _imagePath = imagePath;

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? dateTime;
  final List<int>? _imagePath;
  @override
  List<int>? get imagePath {
    final value = _imagePath;
    if (value == null) return null;
    if (_imagePath is EqualUnmodifiableListView) return _imagePath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? imageName;
  @override
  final String? timeReminder;

  @override
  String toString() {
    return 'Agenda(id: $id, title: $title, description: $description, dateTime: $dateTime, imagePath: $imagePath, imageName: $imageName, timeReminder: $timeReminder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            const DeepCollectionEquality()
                .equals(other._imagePath, _imagePath) &&
            (identical(other.imageName, imageName) ||
                other.imageName == imageName) &&
            (identical(other.timeReminder, timeReminder) ||
                other.timeReminder == timeReminder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, dateTime,
      const DeepCollectionEquality().hash(_imagePath), imageName, timeReminder);

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      __$$AgendaImplCopyWithImpl<_$AgendaImpl>(this, _$identity);
}

abstract class _Agenda implements Agenda {
  const factory _Agenda(
      {final int? id,
      final String? title,
      final String? description,
      final String? dateTime,
      final List<int>? imagePath,
      final String? imageName,
      final String? timeReminder}) = _$AgendaImpl;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get dateTime;
  @override
  List<int>? get imagePath;
  @override
  String? get imageName;
  @override
  String? get timeReminder;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
