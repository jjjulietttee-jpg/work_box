import 'package:flutter/material.dart';

class ConverterSwapButton extends StatefulWidget {
  final VoidCallback onTap;

  const ConverterSwapButton({
    super.key,
    required this.onTap,
  });

  @override
  State<ConverterSwapButton> createState() => _ConverterSwapButtonState();
}

class _ConverterSwapButtonState extends State<ConverterSwapButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _rotationController.forward().then((_) {
      _rotationController.reverse();
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Center(
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(isDark ? 0.15 : 0.1),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 3.14159,
                child: Icon(
                  Icons.swap_vert,
                  color: theme.colorScheme.onPrimary,
                  size: 28,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

