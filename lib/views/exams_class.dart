import 'package:flutter/material.dart';
import 'package:notes_app/widgets/exams_container.dart';

class ExamsClass extends StatelessWidget {
  const ExamsClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Expanded(child: ExamsContainer(title: 'first exam '))],
      ),
    );
  }
}
