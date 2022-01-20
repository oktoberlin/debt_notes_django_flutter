const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, theBorrower, borrowerType, nominal, description, dateBorrowed,
    timeBorrowed
  ];

  static const String id = 'id';
  static const String theBorrower = 'theBorrower';
  static const String borrowerType = 'borrowerType';
  static const String nominal = 'nominal';
  static const String description = 'description';
  static const String dateBorrowed = 'dateBorrowed';
  static const String timeBorrowed = 'timeBorrowed';
}

class Note {
  final int? id;
  final String theBorrower;
  final String borrowerType;
  final int nominal;
  final String description;
  final String dateBorrowed;
  final String timeBorrowed;
  Note({
    this.id,
    required this.theBorrower,
    required this.borrowerType,
    required this.nominal,
    required this.description,
    required this.dateBorrowed,
    required this.timeBorrowed,
  });

  Note copy({
    int? id,
    String? theBorrower,
    String? borrowerType,
    int? nominal,
    String? description,
    String? dateBorrowed,
    String? timeBorrowed,
  }) =>
      Note(
        id: id ?? this.id,
        theBorrower: theBorrower ?? this.theBorrower,
        borrowerType: borrowerType ?? this.borrowerType,
        nominal: nominal ?? this.nominal,
        description: description ?? this.description,
        dateBorrowed: dateBorrowed ?? this.dateBorrowed,
        timeBorrowed: timeBorrowed ?? this.timeBorrowed,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        theBorrower: json[NoteFields.theBorrower] as String,
        borrowerType: json[NoteFields.borrowerType] as String,
        nominal: json[NoteFields.nominal] as int,
        description: json[NoteFields.description] as String,
        dateBorrowed: json[NoteFields.dateBorrowed] as String,
        timeBorrowed: json[NoteFields.timeBorrowed] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.theBorrower: theBorrower,
        NoteFields.borrowerType: borrowerType,
        NoteFields.nominal: nominal,
        NoteFields.description: description,
        NoteFields.dateBorrowed: dateBorrowed,
        NoteFields.timeBorrowed: timeBorrowed,
      };
}
