import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/views/firstnote_page.dart';
import 'package:notes_app/widgets/note_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SavedNotesPage extends StatefulWidget {
  const SavedNotesPage({super.key});

  @override
  State<SavedNotesPage> createState() => _SavedNotesPageState();
}

class _SavedNotesPageState extends State<SavedNotesPage> {
  List<Note> notes = [];
  bool isLoading = true;

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('notes') ?? [];

    return rawList.map((jsonStr) {
      final map = jsonDecode(jsonStr);
      return Note.fromMap(map);
    }).toList();
  }

  Future<void> deleteNote(int index) async {
    setState(() {
      notes.removeAt(index);
    });

    // Update SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final notesJson = notes.map((note) => jsonEncode(note.toMap())).toList();
    await prefs.setStringList('notes', notesJson);
  }

  Future<void> refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    final loadedNotes = await loadNotes();
    setState(() {
      notes = loadedNotes;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset('lib/icons/bottom left logo.svg'),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SvgPicture.asset('lib/icons/background ( all logos ).svg'),
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 24),
                ...notes.asMap().entries.map((entryData) {
                  int index = entryData.key;
                  Note note = entryData.value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
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
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              onPressed: () => deleteNote(index),
                              iconSize: 24,
                            ),
                          ],
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
                              Expanded(child: Text(item.text)),
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

                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FirstnotePage(),
                          ),
                        );
                      }
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
            ),
        ],
      ),
    );
  }
}
