import 'package:flutter/material.dart';
import 'package:notes_app/widgets/exam_entry.dart';

class ExamsContainer extends StatefulWidget {
  final String title;
  const ExamsContainer({required this.title, super.key});

  @override
  State<ExamsContainer> createState() => _ExamsContainerState();
}

class _ExamsContainerState extends State<ExamsContainer> {
  List<ExamEntry> entries = [ExamEntry()];

  void addEntry() {
    setState(() {
      entries.add(ExamEntry());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Just a Column of Rows
            Column(
              children: entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(hintText: 'Date'),
                          onChanged: (val) => entry.date = val,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(hintText: 'Time'),
                          onChanged: (val) => entry.time = val,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Subject',
                          ),
                          onChanged: (val) => entry.subject = val,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.blue),
                onPressed: addEntry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
