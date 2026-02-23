import 'package:event_planner_frontend/ui/ro_editor/view_models/ro_editor_view_model.dart';
import 'package:flutter/material.dart';

/// The RoEditorTable widget allows the user to see
/// and edit the details of the running-order, such as
/// its event blocks and event sections. It is
/// controlled by the [RoEditorToolBar] widget.
class RoEditorTable extends StatelessWidget {
  const RoEditorTable({super.key, required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TableHeader(),
        Expanded(
          child: ListenableBuilder(
            listenable: Listenable.merge([editorViewModel.eventBlocks, editorViewModel.editMode]),
            builder: (context, child) {
              var itemCountLength = editorViewModel.editMode.value == .base
                  ? editorViewModel.eventBlocks.value.length
                  : (editorViewModel.eventBlocks.value.length * 2) + 2;
              return ListView.builder(
                itemCount: itemCountLength,
                itemBuilder: (context, index) {
                  switch (editorViewModel.editMode.value) {
                    case .base:
                      return FractionallySizedBox(
                        widthFactor: 100,
                        child: _EventBlockContainer(
                          editorViewModel: editorViewModel,
                          blockIndex: index,
                        ),
                      );
                    case .add:
                      if (index == itemCountLength - 1) {
                        return SizedBox(height: 100);
                      }
                      if (index % 2 == 0) {
                        return _InsertEventBlockDivider(
                          editorViewModel: editorViewModel,
                          insertAtIndex: index ~/ 2,
                        );
                      } else {
                        var block = editorViewModel.eventBlocks.value[index ~/ 2].value;
                        return _EventBlockContainer(
                          key: Key('event-block-${block.id}'),
                          editorViewModel: editorViewModel,
                          blockIndex: index ~/ 2,
                        );
                      }
                    case .delete:
                      return null;
                    case .paste:
                      return null;
                    case .sort:
                      return null;
                  }
                },
              );
            },
          ),
        ),
      ],
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
    super.key,
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
      text: widget.editorViewModel.eventBlocks.value[widget.blockIndex].value.title,
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
    var blockNotifier = widget.editorViewModel.eventBlocks.value[widget.blockIndex];

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
                child: ValueListenableBuilder(
                  valueListenable: blockNotifier,
                  builder: (context, block, child) => OutlinedButton(
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
            ),
          if (widget.blockIndex != 0)
            ValueListenableBuilder(
              valueListenable: blockNotifier,
              builder: (context, block, child) {
                return Text(
                  widget.editorViewModel.convertBlockTimeToTimestamp(
                    block.startTime,
                  ),
                );
              }
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
