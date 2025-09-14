import 'package:flutter/material.dart';
import 'package:notes_app/views/Notes_view.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NotesView()),
          );
        },
        child: Center(child: Icon(Icons.arrow_back, color: Colors.black)),
      ),
    );
  }
}
