import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/views/firstnote_page.dart';
import 'package:notes_app/views/savednote_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteClass extends StatefulWidget {
  const NoteClass({super.key});

  @override
  State<NoteClass> createState() => _NoteClassState();
}

@override
class _NoteClassState extends State<NoteClass> {
  Future<void> checkSavedNote(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final title = prefs.getString('note_title') ?? '';
    final category = prefs.getString('note_category') ?? '';
    final content = prefs.getString('note_content') ?? '';

    final hasData =
        title.isNotEmpty || category.isNotEmpty || content.isNotEmpty;

    if (hasData) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SavedNotesPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NoteClass()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text(
              'Create Your First Note ...',
              style: TextStyle(fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext) {
                    return FirstnotePage();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff379c8a),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 50,
                width: 150,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    Text(
                      'New note',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SvgPicture.asset('lib/icons/background ( all logos ).svg'),
        ],
      ),
    );
  }
}
