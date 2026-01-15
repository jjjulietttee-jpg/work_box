import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';
import '../models/note_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource dataSource;

  NotesRepositoryImpl(this.dataSource);

  @override
  Future<List<Note>> getNotes() async {
    final models = await dataSource.getNotes();
    return models;
  }

  @override
  Future<Note> getNoteById(String id) async {
    final model = await dataSource.getNoteById(id);
    if (model == null) {
      throw Exception('Note not found');
    }
    return model;
  }

  @override
  Future<void> saveNote(Note note) async {
    final model = NoteModel.fromEntity(note);
    await dataSource.saveNote(model);
  }

  @override
  Future<void> deleteNote(String id) async {
    await dataSource.deleteNote(id);
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    final notes = await getNotes();
    final lowerQuery = query.toLowerCase();
    return notes.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
          note.content.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}

