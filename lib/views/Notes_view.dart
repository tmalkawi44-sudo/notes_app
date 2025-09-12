import 'package:flutter/material.dart';
import 'package:notes_app/views/exams_class.dart';
import 'package:notes_app/views/note_class.dart';

class NotesView extends StatefulWidget {
  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  List<bool> isSelected = [true, false];

  Widget getBody() {
    if (isSelected[0]) {
      return NoteClass();
    } else if (isSelected[1]) {
      return ExamsClass();
    }
    return Center(
      child: Text("❓ Unknown View", style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Toggle Body Example")),
      body: getBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ToggleButtons(
          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Notes"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Exams"),
            ),
          ],
        ),
      ),
    );
  }
}
