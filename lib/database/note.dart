class Note {
  int id;
  String title;
  String content;
  String dateTime;
  Note(
      {required this.content,
      required this.dateTime,
      this.title = '',
      this.id = 0});
  factory Note.fromMap(Map<String, dynamic> map) {
    String title = map['title'];
    if (title.isEmpty) {
      title = '(Trống)';
    }
    return Note(
      id: map['id'],
      title: title,
      content: map["content"],
      dateTime: map["date_time"],
    );
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "content": content, "date_time": dateTime};
}
