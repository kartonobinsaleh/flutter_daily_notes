import 'package:equatable/equatable.dart';
import 'package:flutter_todo_list/models/note.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends HydratedBloc<NoteEvent, NoteState> {
  NoteBloc() : super(const NoteState()) {
    on<NoteStarted>(_onStarted);
    on<AddNote>(_onAddNote);
    on<RemoveNote>(_onRemoveNote);
    on<UpdateNote>(_onUpdateNote);
  }

  void _onStarted(
    NoteStarted event,
    Emitter<NoteState> emit,
  ) {
    if (state.status == NoteStatus.success) return;
    emit(state.copyWith(notes: state.notes, status: NoteStatus.success));
  }

  void _onAddNote(
    AddNote event,
    Emitter<NoteState> emit,
  ) {
    emit(
      state.copyWith(
        status: NoteStatus.loading,
      ),
    );

    try {
      List<Note> temp = [];
      temp.addAll(state.notes);
      temp.insert(0, event.note);
      emit(
        state.copyWith(
          notes: temp,
          status: NoteStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  void _onRemoveNote(
    RemoveNote event,
    Emitter<NoteState> emit,
  ) {
    emit(
      state.copyWith(
        status: NoteStatus.loading,
      ),
    );
    try {
      state.notes.remove(event.note);
      emit(
        state.copyWith(
          notes: state.notes,
          status: NoteStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NoteStatus.error,
        ),
      );
    }
  }

  void _onUpdateNote(
    UpdateNote event,
    Emitter<NoteState> emit,
  ) {
    emit(
      state.copyWith(
        status: NoteStatus.loading,
      ),
    );

    try {
      final index = state.notes.indexWhere((note) => note.id == event.noteId);

      if (index != -1) {
        state.notes[index] = event.updatedNote.copyWith(
          title: event.updatedNote.title,
          description: event.updatedNote.description,
        );

        emit(
          state.copyWith(
            notes: state.notes,
            status: NoteStatus.success,
          ),
        );
      } else {
        emit(state.copyWith(status: NoteStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error));
    }
  }

  @override
  NoteState? fromJson(Map<String, dynamic> json) {
    return NoteState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NoteState state) {
    return state.toJson();
  }
}
