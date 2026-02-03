import 'package:event_planner_frontend/ui/core/themes/themes.dart';
import 'package:event_planner_frontend/ui/ro_editor/view_models/ro_editor_view_model.dart';
import 'package:event_planner_frontend/ui/ro_editor/widgets/ro_editor_table_widget.dart';
import 'package:event_planner_frontend/ui/ro_editor/widgets/ro_editor_tool_bar_widget.dart';
import 'package:flutter/material.dart';

/// The RoEditor is a widget that allows the user to
/// create and edit the running-order of an event.
///
///
/// The RoEditor widget is made out of two parts: the [RoEditorToolBar] widget,
/// which controls several main actions of the editor, and the [RoEditorTable]
/// widget, where most of the details of the running-order can be edited.
class RoEditor extends StatefulWidget {
  const RoEditor({super.key});

  @override
  State<RoEditor> createState() => _RoEditorState();
}

class _RoEditorState extends State<RoEditor> {
  late final RoEditorViewModel editorViewModel;

  @override
  void initState() {
    editorViewModel = RoEditorViewModel();
    super.initState();
  }

  @override
  void dispose() {
    editorViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var desktopView = MediaQuery.sizeOf(context).width > mobilePixelThreshold;

    if (desktopView) {
      return SingleChildScrollView(
        child: Column(
          children: [
            RoEditorToolBar(editorViewModel: editorViewModel),
            RoEditorTable(editorViewModel: editorViewModel),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: .topCenter,
            children: [
              SingleChildScrollView(
                child: RoEditorTable(editorViewModel: editorViewModel),
              ),
              Positioned(
                bottom: 25,
                child: RoEditorToolBar(editorViewModel: editorViewModel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
