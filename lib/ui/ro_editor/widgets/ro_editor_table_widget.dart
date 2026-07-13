import 'package:event_planner_frontend/data/models/event_section.dart';
import 'package:event_planner_frontend/ui/ro_editor/view_models/ro_editor_view_model.dart';
import 'package:flutter/material.dart';

/// The RoEditorTable widget allows the user to see
/// and edit the details of the running-order, such as
/// its event blocks and event sections. It is
/// controlled by the [RoEditorToolBar] widget.
class RoEditorTable extends StatelessWidget {
  const RoEditorTable({super.key, required this.editorViewModel});

  final RoEditorViewModel editorViewModel;

  /// Calculates the total number of widgets that will need to be rendered
  /// on the RoEditor table.
  int _calculateListLength() {
    var total = 0;
    for (var blockNotifier in editorViewModel.eventBlocks.value) {
      total += 1 + blockNotifier.value.eventSections.length;
    }
    // Add one more for the SizedBox spacer at the end.
    return total + 1;
  }

  /// Calculates the indexes of the block widgets relative to the entire table
  /// and maps these indexes to the indexes of the block models stored
  /// in the view model. The key is the widget index of the block relative
  /// to the entire widget ListView. The value is the block index relative
  /// to the event blocks list stored in the view model.
  Map<int, int> _calculateBlockIndexes() {
    final blockIndexes = <int, int>{};
    var currFlatIndex = 0;
    var blockOrder = 0;
    for (var i = 0; i < editorViewModel.eventBlocks.value.length; i++) {
      blockIndexes[currFlatIndex] = blockOrder;
      var block = editorViewModel.eventBlocks.value[i].value;
      for (var ii = 0; ii < block.eventSections.length; ii++) {
        currFlatIndex++;
      }
      currFlatIndex++;
      blockOrder++;
    }
    return blockIndexes;
  }

  EventSection _getEventSectionFromListViewIndex(int listViewIndex) {
    var currListViewIndex = 0;
    for (var i = 0; i < editorViewModel.eventBlocks.value.length; i++) {
      currListViewIndex++;
      var block = editorViewModel.eventBlocks.value[i].value;
      for (var ii = 0; i < block.eventSections.length; ii++) {
        if (currListViewIndex == listViewIndex) {
          return block.eventSections[ii];
        }
        currListViewIndex++;
      }
    }
    throw ArgumentError(
      'Invalid listViewIndex given: $listViewIndex',
      'listViewIndex',
    );
  }

  /// Generates the appropriate widget for the main ListView according to
  /// several parameters given.
  Widget _getListViewRowWidgetAt(
    int index,
    Map<int, int> blockIndexes,
    bool last,
  ) {
    if (last) {
      const spacer = SizedBox(height: 100);
      return switch (editorViewModel.editMode.value) {
        .add => Column(
          children: [
            _InsertEventBlockDivider(
              insertAtIndex: index,
              editorViewModel: editorViewModel,
            ),
            spacer,
          ],
        ),
        _ => spacer,
      };
    } else if (blockIndexes.containsKey(index)) {
      final blockModel =
          editorViewModel.eventBlocks.value[blockIndexes[index]!].value;
      final blockContainer = FractionallySizedBox(
        widthFactor: 100,
        child: _EventBlockContainer(
          key: Key('event-block-${blockModel.id}'),
          editorViewModel: editorViewModel,
          blockIndex: index,
        ),
      );
      return switch (editorViewModel.editMode.value) {
        .add => Column(
          children: [
            _InsertEventBlockDivider(
              insertAtIndex: blockIndexes[index]!,
              editorViewModel: editorViewModel,
            ),
            blockContainer,
          ],
        ),
        _ => blockContainer,
      };
    } else {
      return switch (editorViewModel.editMode.value) {
        _ => _EventSectionContainer(
          key: Key(
            'event-section-${_getEventSectionFromListViewIndex(index).id}',
          ),
        ),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TableHeader(),
        Expanded(
          child: ListenableBuilder(
            listenable: Listenable.merge([
              editorViewModel.eventBlocks,
              editorViewModel.editMode,
            ]),
            builder: (context, child) {
              final itemCountLength = _calculateListLength();
              final blockIndexes = _calculateBlockIndexes();
              return ListView.builder(
                itemCount: itemCountLength,
                itemBuilder: (context, index) {
                  return _getListViewRowWidgetAt(
                    index,
                    blockIndexes,
                    index == itemCountLength - 1,
                  );
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
      text: widget
          .editorViewModel
          .eventBlocks
          .value[widget.blockIndex]
          .value
          .title,
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
    var blockNotifier =
        widget.editorViewModel.eventBlocks.value[widget.blockIndex];

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _getTableBorderColor(context)),
        ),
      ),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          Text(
            'Block ${widget.editorViewModel.intToRomanNumber(widget.blockIndex + 1)}',
          ),
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
                          initialEntryMode: TimePickerEntryMode.inputOnly,
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
              },
            ),
        ],
      ),
    );
  }
}

class _EventSectionContainer extends StatefulWidget {
  const _EventSectionContainer({super.key});

  @override
  State<_EventSectionContainer> createState() => _EventSectionContainerState();
}

class _EventSectionContainerState extends State<_EventSectionContainer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
