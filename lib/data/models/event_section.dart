import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_section.freezed.dart';
part 'event_section.g.dart';

@freezed
abstract class EventSection with _$EventSection {
  const factory EventSection() = _EventSection;

  factory EventSection.fromJson(Map<String, Object?> json) => _$EventSectionFromJson(json);
}
