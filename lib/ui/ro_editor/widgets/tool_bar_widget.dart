import 'package:event_planner_frontend/ui/core/themes/themes.dart';
import 'package:flutter/material.dart';

/// Creates a RO Editor toolbar that can be used to interact with
/// the [RoEditorTable].
class ToolBar extends StatelessWidget {
  ToolBar({super.key});

  final iconButtonData =
      <({IconData icon, String tooltip, void Function() action})>[
        (
          icon: Icons.delete_outline,
          tooltip: 'Delete selected block/section',
          action: () {},
        ),
        (
          icon: Icons.swap_vert,
          tooltip: 'Re-arrange blocks/sections',
          action: () {},
        ),
        (icon: Icons.add, tooltip: 'Add block/section', action: () {}),
        (icon: Icons.copy, tooltip: 'Copy block/section', action: () {}),
        (icon: Icons.paste, tooltip: 'Paste block/section', action: () {}),
        (
          icon: Icons.remove_red_eye_outlined,
          tooltip: 'Toggle view mode',
          action: () {},
        ),
      ];

  /// Generates a list of Icon buttons for the toolbar.
  List<Widget> _getToolbarButtons(BuildContext context) {
    return [
      for (var (:icon, :tooltip, :action) in iconButtonData)
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          // TODO: Implement actions for these buttons once they've been implemented.
          child: _ToolbarButton(
            icon: icon,
            tooltip: tooltip,
            onPressed: action,
          ),
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

/// Helper widget class for the toolbar icon buttons.
class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).primaryColor),
      tooltip: tooltip,
    );
  }
}
