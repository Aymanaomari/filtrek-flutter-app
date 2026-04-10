import 'package:filtrek_app/core/constant/end_points.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/domain/entities/appointment/client_appointment_entity.dart';
import 'package:flutter/material.dart';

class CustomAppointmentItem extends StatelessWidget {
  final ClientAppointmentEntity appointment;

  const CustomAppointmentItem({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outline, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeBar(context, colors),
              _buildCoachInfo(colors),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBar(BuildContext context, ColorScheme colors) {
    final start = appointment.startTime;
    final end = appointment.endTime;
    return Container(
      height: 40,
      width: 120,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 54,
            child: Container(
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(99),
              ),
              height: 40,
              alignment: Alignment.center,
              child: Text(
                _formatTime(start),
                style: AppTypography.caption.copyWith(
                  color: colors.surface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 0,
            child: ClipPath(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(99),
                    bottomRight: Radius.circular(99),
                  ),
                ),
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  _formatTime(end),
                  style: AppTypography.caption.copyWith(
                    color: colors.surface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  Widget _buildCoachInfo(ColorScheme colors) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.coachName,
              style: AppTypography.caption.copyWith(
                color: colors.onSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              appointment.coachProfession,
              style: AppTypography.caption.copyWith(color: colors.outline),
            )
          ],
        ),
        const SizedBox(width: 6),
        _buildCoachPicture(appointment.coachProfile),
      ],
    );
  }

  Widget _buildCoachPicture(String coachId) {
    final url = _formatProfilePictureUrl(coachId);
    return ClipOval(
      child: Image.network(
        url,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 24,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  String _formatProfilePictureUrl(String id) {
    if (id.isEmpty || id == 'null') {
      return 'https://ui-avatars.com/api/?name=Coach';
    }
    if (id.startsWith('http://') || id.startsWith('https://')) {
      return id;
    }
    return "${EndPoints.endPointsPrefix}/api/user/profile-picture/$id";
  }
}
