import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_app/views/exams_class.dart';
import 'package:notes_app/views/firstnote_page.dart';
import 'package:notes_app/views/note_class.dart';
import 'package:notes_app/widgets/note_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SavedNotesPage extends StatelessWidget {
  const SavedNotesPage({super.key});

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('notes') ?? [];

    return rawList.map((jsonStr) {
      final map = jsonDecode(jsonStr);
      return Note.fromMap(map);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Note>>(
        future: loadNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final notes = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                '📝 Your Saved Notes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'You have ${notes.length} note${notes.length == 1 ? '' : 's'} saved.',
              ),
              const SizedBox(height: 24),
              ...notes.map((note) {
                final checklist = NoteItem.decode(note.content);
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: ${note.title}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Category: ${note.category}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      ...checklist.map(
                        (item) => Row(
                          children: [
                            Icon(
                              item.isChecked
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                            const SizedBox(width: 8),
                            Text(item.text),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('note_title');
                    await prefs.remove('selected_category');
                    await prefs.remove('notes_data');

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstnotePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
