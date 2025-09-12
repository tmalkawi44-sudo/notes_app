import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/views/firstnote_page.dart';

class NoteClass extends StatelessWidget {
  const NoteClass({super.key});

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
