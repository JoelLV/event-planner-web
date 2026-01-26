import 'package:event_planner_frontend/data/models/event_section.dart';

class EventBlock {
  EventBlock({
    required this.startTime,
    required this.title,
    this.eventSections = const [],
  });

  DateTime startTime;
  String title;
  List<EventSection> eventSections;
}
