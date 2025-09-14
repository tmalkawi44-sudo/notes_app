import 'package:flutter/material.dart';
import 'package:notes_app/views/firstnote_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedNotePage extends StatelessWidget {
  const SavedNotePage({super.key});

  Future<Map<String, String>> loadNoteData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'title': prefs.getString('note_title') ?? '',
      'category': prefs.getString('note_category') ?? '',
      'content': prefs.getString('note_content') ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, String>>(
        future: loadNoteData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: ${data['title']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Category: ${data['category']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Content: ${data['content']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstnotePage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
