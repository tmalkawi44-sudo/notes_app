import 'dart:convert';

class Note {
  final String title;
  final String content;
  final String category;

  Note({required this.title, required this.content, required this.category});

  Map<String, String> toMap() => {
    'title': title,
    'content': content,
    'category': category,
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    title: map['title'],
    content: map['content'],
    category: map['category'],
  );
}

class NoteItem {
  bool isChecked;
  String text;

  NoteItem({this.isChecked = false, this.text = ''});

  Map<String, dynamic> toMap() {
    return {'isChecked': isChecked, 'text': text};
  }

  factory NoteItem.fromMap(Map<String, dynamic> map) {
    return NoteItem(
      isChecked: map['isChecked'] ?? false,
      text: map['text'] ?? '',
    );
  }

  static String encode(List<NoteItem> notes) =>
      json.encode(notes.map((note) => note.toMap()).toList());

  static List<NoteItem> decode(String notes) =>
      (json.decode(notes) as List<dynamic>)
          .map((item) => NoteItem.fromMap(item))
          .toList();
}
