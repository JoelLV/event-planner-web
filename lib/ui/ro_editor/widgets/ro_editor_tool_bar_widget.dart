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
  List<Widget> _getToolbarButtons(BuildContext context) {
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
          child: Row(
            mainAxisAlignment: .center,
            children: _getToolbarButtons(context),
          ),
        ),
      ),
    );
  }
}

/// Implementation of the add button for adding
/// event blocks/sections to the RoEditor.
class _AddButton extends StatefulWidget {
  const _AddButton({required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton> {
  final FocusNode _addButtonFocusNode = FocusNode(debugLabel: 'Add Button');

  /// Cleanup focus node for child button.
  @override
  void dispose() {
    _addButtonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Add block/section',
      focusNode: _addButtonFocusNode,
      onPressed: () {
        widget.editorViewModel.changeEditMode(.add);
      },
      icon: Icon(Icons.add),
    );
  }
}
