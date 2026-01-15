import 'package:flutter/material.dart';

import '../../theme/app_border_radius.dart';
import '../../theme/theme_extensions.dart';

class GlowTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFocusLost;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final bool readOnly;

  const GlowTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onFocusLost,
    this.keyboardType,
    this.style,
    this.readOnly = false,
  });

  @override
  State<GlowTextField> createState() => _GlowTextFieldState();
}

class _GlowTextFieldState extends State<GlowTextField>
    with SingleTickerProviderStateMixin {
  late final FocusNode _focusNode;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _focusNode.addListener(_onFocusChange);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus && widget.controller != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.controller != null && _focusNode.hasFocus) {
          widget.controller!.selection = TextSelection(
            baseOffset: 0,
            extentOffset: widget.controller!.text.length,
          );
        }
      });
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _glowController.forward();
    } else {
      _glowController.reverse();
      widget.onFocusLost?.call();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(
                  (isDark ? 0.12 : 0.08) * _glowAnimation.value,
                ),
                blurRadius: 8 * _glowAnimation.value,
                spreadRadius: 1 * _glowAnimation.value,
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            style: widget.style,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: context.textTertiaryColor),
              filled: true,
              fillColor: context.cardBgLightColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.md),
                borderSide: BorderSide(
                  color: context.glassBorderColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.md),
                borderSide: BorderSide(
                  color: context.glassBorderColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.md),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

