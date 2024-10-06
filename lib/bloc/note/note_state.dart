part of 'note_bloc.dart';

enum NoteStatus { initial, loading, success, error }

class NoteState extends Equatable {
  final List<Note> notes;
  final NoteStatus status;

  const NoteState({
    this.notes = const <Note>[],
    this.status = NoteStatus.initial,
  });

  NoteState copyWith({
    NoteStatus? status,
    List<Note>? notes,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  factory NoteState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfNotes = (json['notes'] as List<dynamic>)
          .map(
            (e) => Note.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      return NoteState(
        notes: listOfNotes,
        status: NoteStatus.values.firstWhere(
          (element) => element.name == json['status'],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes.map((note) => note.toJson()).toList(),
      'status': status.name,
    };
  }

  @override
  List<Object?> get props => [notes, status];
}
