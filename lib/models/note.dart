class Note {
  final int id;
  final String title;
  final String description;
  bool isDone;

  Note({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.isDone = false,
  });

  Note copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return '''Note: {
      id: $id\n
      title: $title\n
      description: $description\n
      isDone: $isDone\n
    }''';
  }
}
