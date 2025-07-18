import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class RemainingScore extends StatefulWidget {
  final int number;
  final IconData icon;
  final String text;
  final Duration? animationDuration;

  const RemainingScore({
    super.key,
    required this.number,
    required this.icon,
    required this.text,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<RemainingScore> createState() => _RemainingScoreState();
}

class _RemainingScoreState extends State<RemainingScore>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _numberAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _numberAnimation = Tween<double>(
      begin: 0.0,
      end: widget.number.toDouble(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(
          widget.icon,
          color: colors.primary,
          size: 56,
        ),
        SizedBox(height: 8),
        AnimatedBuilder(
          animation: _numberAnimation,
          builder: (context, child) {
            return Text(
              _numberAnimation.value.round().toString(),
              style: AppTypography.h2.copyWith(color: colors.onSecondary),
            );
          },
        ),
        SizedBox(height: 8),
        Text(
          widget.text,
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(color: colors.outline),
        ),
      ],
    );
  }
}
