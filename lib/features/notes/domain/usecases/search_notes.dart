import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class SearchNotes {
  final NotesRepository repository;

  SearchNotes(this.repository);

  Future<List<Note>> call(String query) async {
    return await repository.searchNotes(query);
  }
}

