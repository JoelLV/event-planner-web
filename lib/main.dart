import 'package:event_planner_frontend/ui/core/themes/themes.dart';
import 'package:event_planner_frontend/ui/ro_editor/widgets/ro_editor_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: Scaffold(
        body: Center(
          child: RoEditor(),
        ),
      )
    );
  }
}