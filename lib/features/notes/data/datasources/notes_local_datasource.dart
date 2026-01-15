import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getNotes();
  Future<NoteModel?> getNoteById(String id);
  Future<void> saveNote(NoteModel note);
  Future<void> deleteNote(String id);
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final SharedPreferences prefs;
  static const String _keyNotes = 'notes';

  NotesLocalDataSourceImpl(this.prefs);

  @override
  Future<List<NoteModel>> getNotes() async {
    final notesJson = prefs.getString(_keyNotes);
    if (notesJson == null) return [];
    try {
      final List<dynamic> decoded = jsonDecode(notesJson) as List<dynamic>;
      return decoded
          .map((json) => NoteModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<NoteModel?> getNoteById(String id) async {
    final notes = await getNotes();
    try {
      return notes.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    final notes = await getNotes();
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      notes[index] = note;
    } else {
      notes.add(note);
    }
    await prefs.setString(
      _keyNotes,
      jsonEncode(notes.map((n) => n.toJson()).toList()),
    );
  }

  @override
  Future<void> deleteNote(String id) async {
    final notes = await getNotes();
    notes.removeWhere((note) => note.id == id);
    await prefs.setString(
      _keyNotes,
      jsonEncode(notes.map((n) => n.toJson()).toList()),
    );
  }
}
