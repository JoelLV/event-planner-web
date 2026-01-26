import 'package:event_planner_frontend/data/models/event_block.dart';
import 'package:event_planner_frontend/ui/ro_editor/view_models/ro_editor_view_model.dart';
import 'package:flutter/material.dart';

/// The RoEditorTable widget allows the user to see
/// and edit the details of the running-order, such as
/// its event blocks and event sections. It is
/// controlled by the [RoEditorToolBar] widget.
class RoEditorTable extends StatelessWidget {
  const RoEditorTable({super.key, required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  Widget _buildTableHeader(BuildContext context) {
    const headerTextStyle = TextStyle(fontStyle: FontStyle.italic);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(40),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('#', style: headerTextStyle),
          Text('Section', style: headerTextStyle),
          Text('Summary', style: headerTextStyle),
          Text('Participants', style: headerTextStyle),
          Text('Start time', style: headerTextStyle),
          Text('Duration', style: headerTextStyle),
          Text('Description', style: headerTextStyle),
        ],
      ),
    );
  }

  Widget _buildBlockWidget(EventBlock block) {
    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTableHeader(context),
      for (var block in editorViewModel.eventBlocks)
        _buildBlockWidget(block)
      ]);
    // return Table(
    //   columnWidths: {0: FixedColumnWidth(40)},
    //   children: [
    //     TableRow(
    //       decoration: BoxDecoration(
    //         border: Border(
    //           bottom: BorderSide(
    //             color: Theme.of(
    //               context,
    //             ).colorScheme.onSurface.withValues(alpha: 0.2),
    //           ),
    //         ),
    //       ),
    //       children: [
    //         Text('#', style: headerTextStyle),
    //         Text('Section', style: headerTextStyle),
    //         Text('Summary', style: headerTextStyle),
    //         Text('Participants', style: headerTextStyle),
    //         Text('Start time', style: headerTextStyle),
    //         Text('Duration', style: headerTextStyle),
    //         Text('Description', style: headerTextStyle),
    //       ],
    //     ),
    //     TableRow(
    //       children: [
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
    //       ]
    //     ),
    //     for (var block in editorViewModel.eventBlocks)
    //       TableRow(
    //         children: [
    //           Placeholder(),
    //           Placeholder(),
    //           Placeholder(),
    //           Placeholder(),
    //           Placeholder(),
    //           Placeholder(),
    //           Placeholder(),
    //         ]
    //       )
    //   ],
    // );
  }
}
