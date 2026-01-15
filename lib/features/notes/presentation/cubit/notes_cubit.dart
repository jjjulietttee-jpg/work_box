import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:work_box/core/services/logger_service.dart';

import '../../domain/entities/note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/save_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/search_notes.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetNotes getNotes;
  final SaveNote saveNote;
  final DeleteNote deleteNote;
  final SearchNotes searchNotes;

  NotesCubit({
    required this.getNotes,
    required this.saveNote,
    required this.deleteNote,
    required this.searchNotes,
  }) : super(NotesInitial());

  Future<void> loadNotes() async {
    emit(NotesLoading());
    try {
      final notes = await getNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      LoggerService.error('Failed to load notes', e);
      emit(NotesError('Failed to load notes'));
    }
  }

  Future<void> createNote(String title, String content) async {
    try {
      final now = DateTime.now();
      final note = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        createdAt: now,
        updatedAt: now,
      );
      await saveNote(note);
      await loadNotes();
    } catch (e) {
      LoggerService.error('Failed to create note', e);
      emit(NotesError('Failed to create note'));
    }
  }

  Future<void> updateNote(Note note, String title, String content) async {
    try {
      final updatedNote = note.copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
      );
      await saveNote(updatedNote);
      await loadNotes();
    } catch (e) {
      LoggerService.error('Failed to update note', e);
      emit(NotesError('Failed to update note'));
    }
  }

  Future<void> removeNote(String id) async {
    try {
      await deleteNote(id);
      await loadNotes();
    } catch (e) {
      LoggerService.error('Failed to delete note', e);
      emit(NotesError('Failed to delete note'));
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      await loadNotes();
      return;
    }
    emit(NotesLoading());
    try {
      final notes = await searchNotes(query);
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      LoggerService.error('Failed to search notes', e);
      emit(NotesError('Failed to search notes'));
    }
  }
}
