import 'package:flutter/material.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/domain/entities/collective_sessions/recent_collective_sessions_entity.dart';

class CollectiveSessionListTile extends StatelessWidget {
  final CollectiveSessionEntity session;
  final VoidCallback? onTap;
  final int index;

  const CollectiveSessionListTile({
    Key? key,
    required this.session,
    this.onTap,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ),
      duration: Duration(milliseconds: 500 + index * 50),
      curve: Curves.easeOut,
      builder: (context, offset, child) {
        return Opacity(
          opacity: offset.dx < 0.05 ? 1.0 : 0.0,
          child: Transform.translate(
            offset: Offset(offset.dx * 50, 0),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.outline.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(Icons.fitness_center,
                      color: Color(0xFFB6FF5B), size: 32),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.status == "scheduled"
                          ? "New Collective Sessions"
                          : session.status,
                      style: AppTypography.body1.copyWith(
                        color: colors.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatDate(session.sessionDate),
                      style: AppTypography.caption.copyWith(
                        color: colors.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.outline, size: 28),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    // You can improve this formatting as needed
    try {
      final dt = DateTime.parse(date);
      return "${_weekday(dt.weekday)}, ${dt.day.toString().padLeft(2, '0')} ${_month(dt.month)}";
    } catch (_) {
      return date;
    }
  }

  String _weekday(int weekday) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[(weekday - 1) % 7];
  }

  String _month(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[(month - 1) % 12];
  }
}
