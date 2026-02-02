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
    // TODO: Implement actual logic for the start time.
    var block = EventBlock(startTime: DateTime.now(), title: '');
    _eventBlocks.insert(index, block);
    notifyListeners();
  }

  /// Modifies an existing event block specified by its index
  /// in the [eventBlocks] list with the given time.
  void setEventBlockData(int index, TimeOfDay time) {
    final block = _eventBlocks[index];
    block.startTime = DateTime.now().copyWith(hour: time.hour, minute: time.minute);

    notifyListeners();
  }

  /// Converts a given number to its equivalent in roman numerals.
  String intToRomanNumber(int n) {
    return '';
  }
}
