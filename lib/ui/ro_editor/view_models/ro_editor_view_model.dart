import 'package:event_planner_frontend/data/models/event_block.dart';
import 'package:flutter/material.dart';

/// Specifies the view types that the RoEditor can be in.
/// [view] presents the editor in a read-only view.
/// [edit] allows the user to edit the fields of the running-order.
/// Specific fields can only be edited depending on the [EditMode]
/// that the editor is in.
enum ViewType { view, edit }

/// Specifies the modes that the RoEditor can be in.
/// [add] is for adding event blocks and sections.
/// [delete] is for deleting event blocks and sections.
/// [sort] is for sorting event blocks and sections.
/// [paste] is for pasting event blocks or sections in the clipboard.
/// [base] is for presenting the default view when the [ViewType] is [ViewType.edit].
enum EditMode { add, delete, sort, paste, base }

/// View model consumed by the RoEditor [RoEditorToolbar] and
/// [RoEditorTable].
class RoEditorViewModel extends ChangeNotifier {
  RoEditorViewModel();

  EditMode get editMode => _editMode;
  EditMode _editMode = .base;

  List<EventBlock> get eventBlocks => _eventBlocks;
  final List<EventBlock> _eventBlocks = [];

  /// Changes the RoEditor edit mode to the given [newMode].
  /// Does not do anything if the mode given is the current mode.
  void changeEditMode(EditMode newMode) {
    if (_editMode == newMode) {
      return;
    }
    _editMode = newMode;
    notifyListeners();
  }

  /// Adds a new block to the specified index.
  void insertEventBlockAt(int index) {
    DateTime startTime = DateTime.now();

    if (index == 0 && _eventBlocks.isNotEmpty) {
      startTime = _eventBlocks[0].startTime;
    }
    var block = EventBlock(startTime: startTime, title: '');
    _eventBlocks.insert(index, block);
    notifyListeners();
  }

  /// Modifies an existing event block specified by its index
  /// in the [eventBlocks] list with the given time.
  void setEventBlockData(int index, {TimeOfDay? time, String? blockName}) {
    final block = _eventBlocks[index];
    if (time != null) {
      if (index != 0) {
        throw ArgumentError.value(
          index,
          'index',
          'value `index` does not equal to 0',
        );
      }
      block.startTime = DateTime.now().copyWith(
        hour: time.hour,
        minute: time.minute,
      );
    }
    if (blockName != null) {
      block.title = blockName;
    }

    if (time != null || blockName != null) {
      notifyListeners();
    }
  }

  /// Converts a given number to its equivalent in roman numerals.
  String intToRomanNumber(int n) {
    return '';
  }

  /// Converts a given [DateTime] object to a string
  /// representation in the format HH:mm am|pm.
  String convertBlockTimeToTimestamp(DateTime time) {
    var hour = time.hour;
    var minute = time.minute;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${hour < 11 ? 'am' : 'pm'}';
  }
}
