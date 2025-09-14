import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes_app/widgets/exam_entry.dart';

class ExamsContainer extends StatefulWidget {
  final String title;
  Color color;
  ExamsContainer({required this.title, required this.color, super.key});

  @override
  State<ExamsContainer> createState() => _ExamsContainerState();
}

class _ExamsContainerState extends State<ExamsContainer> {
  List<ExamEntry> entries = [];
  @override
  void initState() {
    super.initState();
    loadExams(); // ✅ Load saved data when the widget starts
  }

  Future<void> loadExams() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('exam_entries');
    print("Loaded exams: $data");
    if (data != null) {
      final decoded = ExamEntry.decode(data);
      setState(() {
        entries = decoded.isEmpty ? [ExamEntry()] : decoded;
      });
    }
  }

  Future<void> saveExams() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = ExamEntry.encode(entries);
    print("Saving exams: $encoded");
    await prefs.setString('exam_entries', encoded);
  }

  void addEntry() {
    setState(() {
      entries.add(ExamEntry());
    });
    saveExams();
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
                            borderRadius: BorderRadius.circular(
                              35,
                            ), // Outer styling
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              2,
                            ), // Optional spacing between layers
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ), // Inner styling
                                color: widget.color,
                              ),
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '     Date',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    entry.date = val;
                                  });
                                  saveExams();
                                },
                              ),
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
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Time',
                            ),
                            onChanged: (val) {
                              setState(() {
                                entry.time = val;
                              });
                              saveExams();
                            },
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
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Subject',
                            ),
                            onChanged: (val) {
                              setState(() {
                                entry.subject = val;
                              });
                              saveExams();
                            },
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
