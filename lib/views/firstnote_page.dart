import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes_app/widgets/categories_selector.dart';
import 'package:notes_app/widgets/note_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FirstnotePage extends StatefulWidget {
  const FirstnotePage({super.key});

  @override
  State<FirstnotePage> createState() => _FirstnotePageState();
}

Future<void> saveNote({
  required String title,
  required String content,
  required String category,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final existingNotes = prefs.getStringList('notes') ?? [];

  final newNote = {'title': title, 'content': content, 'category': category};
  final jsonString = jsonEncode(newNote);
  existingNotes.add(jsonString);

  await prefs.setStringList('notes', existingNotes);
}

class _FirstnotePageState extends State<FirstnotePage> {
  List<NoteItem> notes = [];
  String selectedCategory = 'Personal';
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadNotes();
    loadSelectedCategory();
    loadTitle();
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = NoteItem.encode(notes);
    await prefs.setString('notes_data', encodedData);
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('notes_data');
    if (data != null) {
      setState(() {
        notes = NoteItem.decode(data);
      });
    }
  }

  Future<void> saveSelectedCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_category', category);
  }

  Future<void> loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final category = prefs.getString('selected_category') ?? 'Personal';
    setState(() {
      selectedCategory = category;
    });
  }

  Future<void> saveTitle(String title) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('note_title', title);
  }

  Future<void> loadTitle() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTitle = prefs.getString('note_title') ?? '';
    setState(() {
      titleController.text = savedTitle;
    });
  }

  void addNote() {
    setState(() {
      notes.add(NoteItem());
    });
    saveNotes();
  }

  void saveFullNote() async {
    final title = titleController.text;
    final content = NoteItem.encode(notes);
    final category = selectedCategory;

    await saveNote(title: title, content: content, category: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your own list'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: saveFullNote),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
            onChanged: saveTitle,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final controller = TextEditingController(
                  text: notes[index].text,
                );
                return Row(
                  children: [
                    Checkbox(
                      value: notes[index].isChecked,
                      onChanged: (value) {
                        setState(() {
                          notes[index].isChecked = value ?? false;
                        });
                        saveNotes();
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onChanged: (val) {
                          notes[index].text = val;
                          saveNotes();
                        },
                        decoration: InputDecoration(
                          hintText: "To_do",
                          suffixIcon: notes[index].isChecked
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          CategorySelector(
            categories: ['Personal', 'Work', 'Finance', 'Other'],
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
              saveSelectedCategory(category);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
