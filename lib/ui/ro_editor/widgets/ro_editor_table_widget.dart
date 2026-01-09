import 'package:flutter/material.dart';

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
