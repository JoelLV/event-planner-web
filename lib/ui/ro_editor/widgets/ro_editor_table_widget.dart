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

  /// Given a list of event blocks, it'll attempt to construct a list of
  /// [_EventBlockContainer] widgets with [_InsertEventBlockDivider] widgets
  /// in-between if editorViewModel.editMode == [EditMode.add].
  List<Widget> _buildEventBlockWidgets(List<EventBlock> blocks) {
    var widgets = <Widget>[
      if (editorViewModel.editMode == .add)
        _InsertEventBlockDivider(
          editorViewModel: editorViewModel,
          insertAtIndex: 0,
        ),
    ];
    for (var i = 0; i < blocks.length; i++) {
      widgets.add(
        FractionallySizedBox(
          widthFactor: 100,
          child: _EventBlockContainer(
            editorViewModel: editorViewModel,
            blockIndex: i,
          ),
        ),
      );
      if (editorViewModel.editMode == .add) {
        widgets.add(
          _InsertEventBlockDivider(
            editorViewModel: editorViewModel,
            insertAtIndex: i + 1,
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: editorViewModel,
      builder: (context, child) {
        return Column(
          children: [
            _TableHeader(),
            ..._buildEventBlockWidgets(editorViewModel.eventBlocks),
            SizedBox(height: 100),
          ],
        );
      },
    );
  }
}

/// Get color of the border for the editor table.
Color _getTableBorderColor(BuildContext context) {
  return Theme.of(context).colorScheme.onSurface.withAlpha(40);
}

/// Helper widget for constructing the dividers between
/// event blocks for inserting new blocks.
class _InsertEventBlockDivider extends StatelessWidget {
  const _InsertEventBlockDivider({
    required this.insertAtIndex,
    required this.editorViewModel,
  });

  final int insertAtIndex;
  final RoEditorViewModel editorViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(child: Divider(indent: 30)),
          FilledButton.icon(
            onPressed: () {
              editorViewModel.insertEventBlockAt(insertAtIndex);
            },
            label: Text('Insert Block'),
            icon: Icon(Icons.add),
          ),
          Expanded(child: Divider(endIndent: 30)),
        ],
      ),
    );
  }
}

/// Helper widget for constructing the event block with all the
/// input fields for the user.
class _EventBlockContainer extends StatefulWidget {
  const _EventBlockContainer({
    required this.editorViewModel,
    required this.blockIndex,
  });

  final RoEditorViewModel editorViewModel;
  final int blockIndex;

  @override
  State<_EventBlockContainer> createState() => _EventBlockContainerState();
}

class _EventBlockContainerState extends State<_EventBlockContainer> {
  late final TextEditingController blockTitleController;

  @override
  void initState() {
    blockTitleController = TextEditingController(
      text: widget.editorViewModel.eventBlocks[widget.blockIndex].title,
    );
    super.initState();
  }

  @override
  void dispose() {
    blockTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var block = widget.editorViewModel.eventBlocks[widget.blockIndex];

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: _getTableBorderColor(context)),
          bottom: BorderSide(color: _getTableBorderColor(context)),
        ),
      ),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          Text('Block ${widget.blockIndex + 1}'),
          SizedBox(
            width: 300,
            child: TextField(
              controller: blockTitleController,
              textAlign: .center,
              decoration: InputDecoration(helperText: 'Block title'),
              onChanged: (value) {
                widget.editorViewModel.setEventBlockData(
                  widget.blockIndex,
                  blockName: value,
                );
              },
            ),
          ),
          SizedBox(height: 15),
          if (widget.blockIndex == 0)
            SizedBox(
              width: 120,
              child: Tooltip(
                message: 'Edit start time',
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () =>
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: block.startTime.hour,
                          minute: block.startTime.minute,
                        ),
                      ).then((value) {
                        if (value != null) {
                          widget.editorViewModel.setEventBlockData(
                            widget.blockIndex,
                            time: value,
                          );
                        }
                      }),
                  child: Text(
                    widget.editorViewModel.convertBlockTimeToTimestamp(
                      block.startTime,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.blockIndex != 0)
            Text(
              widget.editorViewModel.convertBlockTimeToTimestamp(
                block.startTime,
              ),
            ),
        ],
      ),
    );
  }
}

/// Helper widget for the table header visible in the RoEditorTable.
class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    const headerTextStyle = TextStyle(fontStyle: .italic);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _getTableBorderColor(context)),
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
}
