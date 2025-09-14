import 'package:flutter/material.dart';
import 'package:notes_app/views/exams_class.dart';
import 'package:notes_app/views/note_class.dart';
import 'package:notes_app/widgets/search_icon.dart';

class NotesView extends StatefulWidget {
  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  List<bool> isSelected = [true, false];

  Widget getBody() {
    if (isSelected[0]) {
      return const NoteClass(); // Shows note creation or saved notes
    } else if (isSelected[1]) {
      return const ExamsClass(); // Shows exams view
    }
    return const Center(
      child: Text("❓ Unknown View", style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 150),
              child: Center(
                child: Text('Note', style: TextStyle(fontSize: 20)),
              ),
            ),
            const Spacer(flex: 1),
            const SearchIcon(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffe5e5e5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ToggleButtons(
                isSelected: isSelected,
                selectedColor: Colors.white,
                color: Colors.black,
                fillColor: const Color(0xff379c8a),
                renderBorder: false,
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
                    child: Container(
                      width: 130,
                      alignment: Alignment.center,
                      child: const Text("Notes"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 130,
                      alignment: Alignment.center,
                      child: const Text("Exams"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: getBody()),
          ],
        ),
      ),
    );
  }
}
