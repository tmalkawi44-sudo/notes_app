import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes_app/widgets/categories_selector.dart';

class FirstnotePage extends StatefulWidget {
  const FirstnotePage({super.key});

  @override
  State<FirstnotePage> createState() => _FirstnotePageState();
}

class _FirstnotePageState extends State<FirstnotePage> {
  List<NoteItem> notes = [];
  String selectedCategory = 'Personal';

  void addNote() {
    setState(() {
      notes.add(NoteItem());
    });
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
                decoration: InputDecoration(
                  hintText: '    Title',
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Checkbox(
                          value: notes[index].isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              notes[index].isChecked = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: notes[index].controller,
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
  bool isChecked = false;
  TextEditingController controller = TextEditingController();
}
