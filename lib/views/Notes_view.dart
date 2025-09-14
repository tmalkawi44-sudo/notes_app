import 'package:flutter/material.dart';
import 'package:notes_app/views/exams_class.dart';
import 'package:notes_app/views/note_class.dart';
import 'package:notes_app/views/savednote_page.dart';
import 'package:notes_app/widgets/search_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesView extends StatefulWidget {
  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  List<bool> isSelected = [true, false];
  bool hasSavedNotes = false;
  bool isLoading = true;
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    checkForSavedNotes();
  }

  Future<void> checkForSavedNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notes = prefs.getStringList('notes') ?? [];

    setState(() {
      hasSavedNotes = notes.isNotEmpty;
      isLoading = false;
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Widget getBody() {
    if (isSelected[0]) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return hasSavedNotes ? const SavedNotesPage() : const NoteClass();
    } else if (isSelected[1]) {
      return ExamsClass(searchQuery: searchQuery);
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
            Expanded(
              child: Center(
                child: Text('Note', style: TextStyle(fontSize: 20)),
              ),
            ),
            SearchIcon(onSearchChanged: onSearchChanged),
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
