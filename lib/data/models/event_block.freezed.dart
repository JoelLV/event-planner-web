// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventBlock implements DiagnosticableTreeMixin {

 int get id; DateTime get startTime; String get title; List<EventSection> get eventSections;
/// Create a copy of EventBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventBlockCopyWith<EventBlock> get copyWith => _$EventBlockCopyWithImpl<EventBlock>(this as EventBlock, _$identity);

  /// Serializes this EventBlock to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EventBlock'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('startTime', startTime))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('eventSections', eventSections));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.eventSections, eventSections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,title,const DeepCollectionEquality().hash(eventSections));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EventBlock(id: $id, startTime: $startTime, title: $title, eventSections: $eventSections)';
}


}

/// @nodoc
abstract mixin class $EventBlockCopyWith<$Res>  {
  factory $EventBlockCopyWith(EventBlock value, $Res Function(EventBlock) _then) = _$EventBlockCopyWithImpl;
@useResult
$Res call({
 int id, DateTime startTime, String title, List<EventSection> eventSections
});




}
/// @nodoc
class _$EventBlockCopyWithImpl<$Res>
    implements $EventBlockCopyWith<$Res> {
  _$EventBlockCopyWithImpl(this._self, this._then);

  final EventBlock _self;
  final $Res Function(EventBlock) _then;

/// Create a copy of EventBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? title = null,Object? eventSections = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,eventSections: null == eventSections ? _self.eventSections : eventSections // ignore: cast_nullable_to_non_nullable
as List<EventSection>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventBlock].
extension EventBlockPatterns on EventBlock {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventBlock() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventBlock value)  $default,){
final _that = this;
switch (_that) {
case _EventBlock():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventBlock value)?  $default,){
final _that = this;
switch (_that) {
case _EventBlock() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime startTime,  String title,  List<EventSection> eventSections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventBlock() when $default != null:
return $default(_that.id,_that.startTime,_that.title,_that.eventSections);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime startTime,  String title,  List<EventSection> eventSections)  $default,) {final _that = this;
switch (_that) {
case _EventBlock():
return $default(_that.id,_that.startTime,_that.title,_that.eventSections);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime startTime,  String title,  List<EventSection> eventSections)?  $default,) {final _that = this;
switch (_that) {
case _EventBlock() when $default != null:
return $default(_that.id,_that.startTime,_that.title,_that.eventSections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventBlock with DiagnosticableTreeMixin implements EventBlock {
  const _EventBlock({required this.id, required this.startTime, required this.title, required final  List<EventSection> eventSections}): _eventSections = eventSections;
  factory _EventBlock.fromJson(Map<String, dynamic> json) => _$EventBlockFromJson(json);

@override final  int id;
@override final  DateTime startTime;
@override final  String title;
 final  List<EventSection> _eventSections;
@override List<EventSection> get eventSections {
  if (_eventSections is EqualUnmodifiableListView) return _eventSections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventSections);
}


/// Create a copy of EventBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventBlockCopyWith<_EventBlock> get copyWith => __$EventBlockCopyWithImpl<_EventBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventBlockToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EventBlock'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('startTime', startTime))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('eventSections', eventSections));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._eventSections, _eventSections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,title,const DeepCollectionEquality().hash(_eventSections));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EventBlock(id: $id, startTime: $startTime, title: $title, eventSections: $eventSections)';
}


}

/// @nodoc
abstract mixin class _$EventBlockCopyWith<$Res> implements $EventBlockCopyWith<$Res> {
  factory _$EventBlockCopyWith(_EventBlock value, $Res Function(_EventBlock) _then) = __$EventBlockCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime startTime, String title, List<EventSection> eventSections
});




}
/// @nodoc
class __$EventBlockCopyWithImpl<$Res>
    implements _$EventBlockCopyWith<$Res> {
  __$EventBlockCopyWithImpl(this._self, this._then);

  final _EventBlock _self;
  final $Res Function(_EventBlock) _then;

/// Create a copy of EventBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? title = null,Object? eventSections = null,}) {
  return _then(_EventBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,eventSections: null == eventSections ? _self._eventSections : eventSections // ignore: cast_nullable_to_non_nullable
as List<EventSection>,
  ));
}


}

// dart format on
