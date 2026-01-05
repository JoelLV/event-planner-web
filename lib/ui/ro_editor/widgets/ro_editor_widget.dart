import 'package:event_planner_frontend/ui/core/themes/themes.dart';
import 'package:flutter/material.dart';

/// The RoEditor is a widget that allows the user to
/// create and edit the running-order of an event.
///
///
/// The RoEditor widget is made out of two parts: the [ToolBar] widget,
/// which controls several main actions of the editor, and the [RoEditorTable]
/// widget, where most of the details of the running-order can be edited.
class RoEditor extends StatelessWidget {
  const RoEditor({super.key});

  @override
  Widget build(BuildContext context) {
    bool desktopView = MediaQuery.sizeOf(context).width > mobilePixelThreshold;

    if (desktopView) {
      return Column(
        children: [
          ToolBar(),
          Expanded(child: RoEditorTable()),
        ],
      );
    } else {
      return Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          RoEditorTable(),
          Positioned(bottom: 25, child: ToolBar()),
        ],
      );
    }
  }
}

/// The RoEditorTable widget allows the user to see
/// and edit the details of the running-order, such as
/// its event blocks and event sections. It is
/// controlled by the [ToolBar] widget.
class RoEditorTable extends StatelessWidget {
  RoEditorTable({super.key});

  final sampleData = List.generate(50, (index) => 'Item: $index');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        bottom: 100,
      ), // Add space at the bottom for the toolbar.
      itemCount: sampleData.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(sampleData[index]),
        ),
      ),
    );
  }
}

/// Creates a RO Editor toolbar that can be used to interact with
/// the [RoEditorTable].
class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  /// Generates a list of Icon buttons for the toolbar.
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
