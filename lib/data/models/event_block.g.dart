// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventBlock _$EventBlockFromJson(Map<String, dynamic> json) => _EventBlock(
  id: (json['id'] as num).toInt(),
  startTime: DateTime.parse(json['startTime'] as String),
  title: json['title'] as String,
  eventSections: (json['eventSections'] as List<dynamic>)
      .map((e) => EventSection.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EventBlockToJson(_EventBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'title': instance.title,
      'eventSections': instance.eventSections,
    };
