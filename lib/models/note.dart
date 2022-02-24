const String tableNotes = "notes";

class NoteFields {

  static final List<String> values = [
    id, isImportant, number, title, description, createdTime
  ];

  static const String id = "_id";
  static const String isImportant = "isImportant";
  static const String number = "number";
  static const String title = "title";
  static const String description = "description";
  static const String createdTime = "createdTime";
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;


  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
});
  
  Note copyWith({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
      }) => Note(
        id: this.id,
        isImportant: this.isImportant,
        number: this.number,
        title: this.title,
        description: this.description,
        createdTime: this.createdTime
  );

  Map<String, Object?> toJson() => {
    NoteFields.id : id,
    NoteFields.title : title,
    NoteFields.isImportant: isImportant ? 1 : 0,
    NoteFields.number : number,
    NoteFields.description : description,
    NoteFields.createdTime : createdTime.toIso8601String(),
  };

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    isImportant: json[NoteFields.isImportant] == 1,
    number: json[NoteFields.number] as int,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
  );

}