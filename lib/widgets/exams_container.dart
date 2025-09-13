import 'package:flutter/material.dart';

import 'package:notes_app/widgets/exam_entry.dart';

class ExamsContainer extends StatefulWidget {
  final String title;
  Color color;
  ExamsContainer({required this.title, required this.color});

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
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: widget.color,
                              ),
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '     Date',
                                ),
                                onChanged: (val) => entry.date = val,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: widget.color,
                            ),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '     Time',
                              ),
                              onChanged: (val) => entry.time = val,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: widget.color,
                          ),
                          child: Center(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '     Subject',
                              ),
                              onChanged: (val) => entry.subject = val,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
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
