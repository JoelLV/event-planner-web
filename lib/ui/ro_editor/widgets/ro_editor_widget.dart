import 'package:flutter/material.dart';

class RoEditor extends StatelessWidget {
  const RoEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [_ToolBar()]);
  }
}

/// Creates a desktop-only view toolbar for the RO editor.
class _ToolBar extends StatelessWidget {
  const _ToolBar();

  /// Generates a list of Icon buttons.
  List<Widget> _getToolbarButtons(BuildContext context) {
    // List of icons to generate.
    const iconButtonData = <({IconData icon, String tooltip})>[
      (icon: Icons.delete_outline, tooltip: 'Delete selected block/section'),
      (icon: Icons.swap_vert, tooltip: 'Re-arrange blocks/sections'),
      (icon: Icons.add, tooltip: 'Add block/section'),
      (icon: Icons.copy, tooltip: 'Copy block/section'),
      (icon: Icons.paste, tooltip: 'Paste block/section'),
      (icon: Icons.remove_red_eye_outlined, tooltip: 'Toggle view mode'),
    ];

    return [
      for (var (:icon, :tooltip) in iconButtonData)
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          // TODO: Implement actions for these buttons once they've been implemented.
          child: _ToolbarButton(icon: icon, tooltip: tooltip, onPressed: () {}),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Card(
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
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).primaryColor),
      tooltip: tooltip,
    );
  }
}
