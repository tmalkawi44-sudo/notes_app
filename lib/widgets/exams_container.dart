import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes_app/widgets/exam_entry.dart';

class ExamsContainer extends StatefulWidget {
  final String title;
  final Color color;
  final String searchQuery;
  const ExamsContainer({
    required this.title,
    required this.color,
    required this.searchQuery,
    super.key,
  });

  @override
  State<ExamsContainer> createState() => _ExamsContainerState();
}

class _ExamsContainerState extends State<ExamsContainer> {
  List<ExamEntry> entries = [];
  Map<int, Map<String, TextEditingController>> controllers = {};

  // Create a unique key for each exam type based on the title
  String get examKey =>
      'exam_entries_${widget.title.toLowerCase().replaceAll(' ', '_')}';

  @override
  void initState() {
    super.initState();
    loadExams(); // ✅ Load saved data when the widget starts
  }

  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    for (var controllerMap in controllers.values) {
      for (var controller in controllerMap.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  TextEditingController getController(int index, String field) {
    if (!controllers.containsKey(index)) {
      controllers[index] = {};
    }
    if (!controllers[index]!.containsKey(field)) {
      controllers[index]![field] = TextEditingController();
    }
    return controllers[index]![field]!;
  }

  void updateController(int index, String field, String value) {
    final controller = getController(index, field);
    if (controller.text != value) {
      controller.text = value;
    }
  }

  Future<void> loadExams() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(examKey);
    print("Loaded exams for ${widget.title}: $data");
    if (data != null) {
      final decoded = ExamEntry.decode(data);
      setState(() {
        entries = decoded.isEmpty ? [ExamEntry()] : decoded;
      });
    } else {
      // Initialize with one empty entry if no data exists
      setState(() {
        entries = [ExamEntry()];
      });
    }
    // Initialize controllers for all entries
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < entries.length; i++) {
      updateController(i, 'date', entries[i].date);
      updateController(i, 'time', entries[i].time);
      updateController(i, 'subject', entries[i].subject);
    }
  }

  Future<void> saveExams() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = ExamEntry.encode(entries);
    print("Saving exams for ${widget.title}: $encoded");
    await prefs.setString(examKey, encoded);
  }

  void addEntry() {
    setState(() {
      entries.add(ExamEntry());
      // Initialize controllers for the new entry
      int newIndex = entries.length - 1;
      updateController(newIndex, 'date', '');
      updateController(newIndex, 'time', '');
      updateController(newIndex, 'subject', '');
    });
    saveExams();
  }

  void deleteEntry(int index) {
    setState(() {
      // Dispose controllers for the deleted entry
      if (controllers.containsKey(index)) {
        for (var controller in controllers[index]!.values) {
          controller.dispose();
        }
        controllers.remove(index);
      }
      entries.removeAt(index);
      // Reindex remaining controllers
      _reindexControllers();
    });
    saveExams();
  }

  void _reindexControllers() {
    Map<int, Map<String, TextEditingController>> newControllers = {};
    int newIndex = 0;
    for (int i = 0; i < entries.length; i++) {
      if (controllers.containsKey(i)) {
        newControllers[newIndex] = controllers[i]!;
        newIndex++;
      }
    }
    controllers = newControllers;
  }

  List<ExamEntry> get filteredEntries {
    if (widget.searchQuery.isEmpty) {
      return entries;
    }
    return entries.where((entry) {
      return entry.date.toLowerCase().contains(
            widget.searchQuery.toLowerCase(),
          ) ||
          entry.time.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
          entry.subject.toLowerCase().contains(
            widget.searchQuery.toLowerCase(),
          );
    }).toList();
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
              children: filteredEntries.map((entry) {
                // Find the original index in the main entries list for deletion
                int originalIndex = entries.indexOf(entry);
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
                                controller: getController(
                                  originalIndex,
                                  'date',
                                ),
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
                            controller: getController(originalIndex, 'time'),
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
                            controller: getController(originalIndex, 'subject'),
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
                      const SizedBox(width: 8),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () => deleteEntry(originalIndex),
                        iconSize: 20,
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
