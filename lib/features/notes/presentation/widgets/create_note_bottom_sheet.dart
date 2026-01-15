import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme_extensions.dart';

class CreateNoteBottomSheet extends StatefulWidget {
  final Function({
    required String title,
    required String content,
  }) onCreateNote;

  final String? initialTitle;
  final String? initialContent;

  const CreateNoteBottomSheet({
    super.key,
    required this.onCreateNote,
    this.initialTitle,
    this.initialContent,
  });

  static Future<void> show({
    required BuildContext context,
    required Function({
      required String title,
      required String content,
    }) onCreateNote,
    String? initialTitle,
    String? initialContent,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: CreateNoteBottomSheet(
          onCreateNote: onCreateNote,
          initialTitle: initialTitle,
          initialContent: initialContent,
        ),
      ),
    );
  }

  @override
  State<CreateNoteBottomSheet> createState() => _CreateNoteBottomSheetState();
}

class _CreateNoteBottomSheetState extends State<CreateNoteBottomSheet> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialTitle != null) {
      _titleController.text = widget.initialTitle!;
    }
    if (widget.initialContent != null) {
      _contentController.text = widget.initialContent!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!mounted) return;

    if (_formKey.currentState!.validate()) {
      widget.onCreateNote(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.5, 0.9],
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        
        return Container(
          decoration: BoxDecoration(
            color: context.cardBgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(isDark ? 0.3 : 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(isDark ? 0.15 : 0.05),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  const _DragHandle(),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(24),
                        physics: const ClampingScrollPhysics(),
                        children: [
                          _Header(isEdit: widget.initialTitle != null),
                          const SizedBox(height: 32),
                          _TitleField(controller: _titleController),
                          const SizedBox(height: 24),
                          _ContentField(controller: _contentController),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  _SubmitButton(
                    onSubmit: _handleSubmit,
                    isEdit: widget.initialTitle != null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: context.textTertiaryColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isEdit;

  const _Header({required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Icon(
            isEdit ? Icons.edit_note : Icons.note_add,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            isEdit ? 'Edit Note' : 'Create New Note',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}

class _TitleField extends StatelessWidget {
  final TextEditingController controller;

  const _TitleField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title *',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: context.textPrimaryColor),
          maxLength: 100,
          decoration: _buildInputDecoration(context, 'Enter note title'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Title is required';
            }
            if (value.trim().length < 3) {
              return 'Title must be at least 3 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _ContentField extends StatelessWidget {
  final TextEditingController controller;

  const _ContentField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          maxLines: 8,
          maxLength: 1000,
          style: TextStyle(color: context.textPrimaryColor),
          decoration: _buildInputDecoration(context, 'Enter note content...'),
        ),
      ],
    );
  }
}

InputDecoration _buildInputDecoration(BuildContext context, String hintText) {
  final theme = Theme.of(context);
  
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: context.textTertiaryColor),
    filled: true,
    fillColor: context.cardBgLightColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: context.glassBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: context.glassBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: theme.colorScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
  );
}

class _SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final bool isEdit;

  const _SubmitButton({
    required this.onSubmit,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.cardBgColor,
        border: Border(top: BorderSide(color: context.glassBorderColor, width: 1)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check, size: 20),
              const SizedBox(width: 8),
              Text(
                isEdit ? 'Save Note' : 'Create Note',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

