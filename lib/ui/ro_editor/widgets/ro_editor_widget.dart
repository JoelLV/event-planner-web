import 'package:event_planner_frontend/ui/core/themes/themes.dart';
import 'package:event_planner_frontend/ui/ro_editor/widgets/ro_editor_table_widget.dart';
import 'package:event_planner_frontend/ui/ro_editor/widgets/tool_bar_widget.dart';
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
