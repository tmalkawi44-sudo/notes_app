import 'package:flutter/material.dart';

class ExamEntry {
  String date;
  String time;
  String subject;

  ExamEntry({this.date = '', this.time = '', this.subject = ''});
}

class ExamSection extends StatefulWidget {
  final String title;
  const ExamSection({required this.title, super.key});

  @override
  State<ExamSection> createState() => _ExamSectionState();
}

class _ExamSectionState extends State<ExamSection> {
  List<ExamEntry> entries = [ExamEntry()];

  void addEntry() {
    setState(() {
      entries.add(ExamEntry());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Date'),
                        onChanged: (val) => entry.date = val,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Time'),
                        onChanged: (val) => entry.time = val,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Subject'),
                        onChanged: (val) => entry.subject = val,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.add_circle, color: Colors.blue),
                onPressed: addEntry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
