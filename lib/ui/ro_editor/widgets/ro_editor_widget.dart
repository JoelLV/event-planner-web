import 'package:flutter/material.dart';

class RoEditor extends StatelessWidget {
  const RoEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ToolBar(),
      ],
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [BoxShadow(blurRadius: 5)],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline)),
            IconButton(onPressed: () {}, icon: Icon(Icons.swap_vert)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
            IconButton(onPressed: () {}, icon: Icon(Icons.paste)),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
          ],
        ),
      ),
    );
  }
}