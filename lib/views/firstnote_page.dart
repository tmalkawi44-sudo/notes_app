import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes_app/widgets/categories_selector.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FirstnotePage extends StatefulWidget {
  const FirstnotePage({super.key});

  @override
  State<FirstnotePage> createState() => _FirstnotePageState();
}

class _FirstnotePageState extends State<FirstnotePage> {
  List<NoteItem> notes = [];
  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = NoteItem.encode(notes);
    await prefs.setString('notes_data', encodedData);
  }

  Future<void> saveSelectedCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_category', category);
  }

  Future<void> loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final category = prefs.getString('selected_category') ?? '';
    setState(() {
      selectedCategory = category;
    });
  }

  TextEditingController titleController = TextEditingController();
  Future<void> saveTitle(String title) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('note_title', title);
  }

  Future<void> loadTitle() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTitle = prefs.getString('note_title') ?? '';
    print("Loaded title: $savedTitle");

    setState(() {
      titleController.text = savedTitle;
    });
  }

  String selectedCategory = 'Personal';
  void initState() {
    super.initState();
    loadNotes();
    loadSelectedCategory();
    loadTitle();
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

  void addNote() {
    setState(() {
      notes.add(NoteItem());
    });
    saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Center(
              child: Text(
                'Create your own list',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 320),
            child: Container(
              child: SvgPicture.asset('lib/icons/upper right logo.svg'),
            ),
          ),
          Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: '    Title',
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  saveTitle(val);
                },
              ),

              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    TextEditingController controller = TextEditingController(
                      text: notes[index].text,
                    );

                    return Row(
                      children: [
                        Checkbox(
                          value: notes[index].isChecked,
                          onChanged: (bool? value) {
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
                                  ? Icon(Icons.check, color: Colors.green)
                                  : null,
                              border: InputBorder.none,
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
              SizedBox(height: 75),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 500),
            child: Container(
              child: SvgPicture.asset('lib/icons/bottom left logo.svg'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteItem {
  bool isChecked;
  String text;

  NoteItem({this.isChecked = false, this.text = ''});

  Map<String, dynamic> toMap() {
    return {'isChecked': isChecked, 'text': text};
  }

  factory NoteItem.fromMap(Map<String, dynamic> map) {
    return NoteItem(isChecked: map['isChecked'], text: map['text']);
  }

  static String encode(List<NoteItem> notes) =>
      json.encode(notes.map((note) => note.toMap()).toList());

  static List<NoteItem> decode(String notes) =>
      (json.decode(notes) as List<dynamic>)
          .map((item) => NoteItem.fromMap(item))
          .toList();
}
