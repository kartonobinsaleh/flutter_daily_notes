part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class AddNote extends NoteEvent {
  final Note note;

  const AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class RemoveNote extends NoteEvent {
  final Note note;

  const RemoveNote(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteEvent {
  final int noteId;
  final Note updatedNote;

  const UpdateNote({
    required this.noteId,
    required this.updatedNote,
  });

  @override
  List<Object?> get props => [noteId, updatedNote];
}

class ClearNotes extends NoteEvent {
  const ClearNotes();
}

class LoadNotes extends NoteEvent {
  const LoadNotes();

  @override
  List<Object?> get props => [];
}
