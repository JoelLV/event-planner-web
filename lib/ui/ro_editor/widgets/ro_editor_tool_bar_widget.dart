import 'package:event_planner_frontend/ui/core/themes/themes.dart';
import 'package:event_planner_frontend/ui/ro_editor/view_models/ro_editor_view_model.dart';
import 'package:flutter/material.dart';

/// Creates a RO Editor toolbar that can be used to interact with
/// the [RoEditorTable].
class RoEditorToolBar extends StatelessWidget {
  const RoEditorToolBar({super.key, required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  // final List<_ToolbarButtonData> _iconButtonData = [
  //   (
  //     icon: Icons.delete_outline,
  //     tooltip: 'Delete selected block/section',
  //     action: () {},
  //   ),
  //   (
  //     icon: Icons.swap_vert,
  //     tooltip: 'Re-arrange blocks/sections',
  //     action: () {},
  //   ),
  //   (icon: Icons.add, tooltip: 'Add block/section', action: () {}),
  //   (icon: Icons.copy, tooltip: 'Copy block/section', action: () {}),
  //   (icon: Icons.paste, tooltip: 'Paste block/section', action: () {}),
  //   (
  //     icon: Icons.remove_red_eye_outlined,
  //     tooltip: 'Toggle view mode',
  //     action: () {},
  //   ),
  // ];

  /// Generates a list of Icon buttons for the toolbar.
  List<Widget> _getToolbarButtons(EditMode mode) {
    if (mode != .base) {
      return [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _DoneButton(editorViewModel: editorViewModel),
        ),
      ];
    }
    return [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: _AddButton(editorViewModel: editorViewModel),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Card(
        elevation:
            // Add elevation only on mobile view.
            MediaQuery.sizeOf(context).width <= mobilePixelThreshold
            ? 10
            : null,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ValueListenableBuilder(
            valueListenable: editorViewModel.editMode,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: .center,
                children: _getToolbarButtons(value),
              );
            }
          ),
        ),
      ),
    );
  }
}

/// Implementation of the add button for adding
/// event blocks/sections to the RoEditor.
class _AddButton extends StatelessWidget {
  const _AddButton({required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Add block/section',
      onPressed: () {
        editorViewModel.changeEditMode(.add);
      },
      icon: Icon(Icons.add),
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Confirm changes',
      onPressed: () {
        editorViewModel.changeEditMode(.base);
      },
      icon: Icon(Icons.check_circle_outline),
    );
  }
}
