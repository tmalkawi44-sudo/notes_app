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
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 150),
              child: Center(
                child: Text('Note', style: TextStyle(fontSize: 20)),
              ),
            ),
            Spacer(flex: 1),
            SearchIcon(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffe5e5e5),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: ToggleButtons(
                  isSelected: isSelected,
                  selectedColor: Colors.white,
                  color: Colors.black,
                  fillColor: Color(0xff379c8a),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 130,
                        child: Text("Notes"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 130,
                        child: Text("Exams"),
                      ),
                    ),
                  ],
                ),
              ),

              getBody(),
            ],
          ),
        ),
      ),
    );
  }
}
