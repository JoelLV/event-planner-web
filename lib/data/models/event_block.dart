import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:event_planner_frontend/data/models/event_section.dart';

part 'event_block.freezed.dart';
part 'event_block.g.dart';

@freezed
abstract class EventBlock with _$EventBlock {
  const factory EventBlock({
    required int id,
    required DateTime startTime,
    required String title,
    required List<EventSection> eventSections,
  }) = _EventBlock;

  factory EventBlock.fromJson(Map<String, Object?> json) => _$EventBlockFromJson(json);
}
