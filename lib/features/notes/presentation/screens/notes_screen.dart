import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../../../../core/shared/widgets/confirmation_dialog.dart';
import '../../../../core/services/activity_tracker_service.dart';
import '../cubit/notes_cubit.dart';
import '../widgets/note_item.dart';
import '../widgets/create_note_bottom_sheet.dart';
import '../../domain/entities/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().loadNotes();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    context.read<NotesCubit>().search(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notes'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search notes...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: context.cardBgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NotesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  if (state is NotesLoaded) {
                    if (state.notes.isEmpty) {
                      return Center(
                        child: Text(
                          'No notes yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
                        return NoteItem(
                          note: note,
                          onTap: () =>
                              _showCreateNoteSheet(context, note: note),
                          onDelete: () =>
                              _showDeleteConfirmation(context, note),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateNoteSheet(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showCreateNoteSheet(BuildContext context, {Note? note}) {
    CreateNoteBottomSheet.show(
      context: context,
      initialTitle: note?.title,
      initialContent: note?.content,
      onCreateNote: ({required String title, required String content}) {
        if (note == null) {
          context.read<NotesCubit>().createNote(title, content);
          ActivityTrackerService.trackEntityCreated('Note', entityName: title);
        } else {
          context.read<NotesCubit>().updateNote(note, title, content);
        }
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Note note) {
    ConfirmationDialog.show(
      context: context,
      title: 'Delete Note',
      message:
          'Are you sure you want to delete "${note.title}"? This action cannot be undone.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      icon: Icons.delete_outline,
      confirmColor: Theme.of(context).colorScheme.error,
      onConfirm: () {
        context.read<NotesCubit>().removeNote(note.id);
      },
    );
  }
}
