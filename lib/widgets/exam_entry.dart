import 'dart:convert';

class ExamEntry {
  String date;
  String time;
  String subject;

  ExamEntry({this.date = '', this.time = '', this.subject = ''});

  Map<String, dynamic> toMap() {
    return {'date': date, 'time': time, 'subject': subject};
  }

  factory ExamEntry.fromMap(Map<String, dynamic> map) {
    return ExamEntry(
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      subject: map['subject'] ?? '',
    );
  }

  static String encode(List<ExamEntry> entries) =>
      json.encode(entries.map((e) => e.toMap()).toList());

  static List<ExamEntry> decode(String entries) =>
      (json.decode(entries) as List<dynamic>)
          .map((e) => ExamEntry.fromMap(e))
          .toList();
}
