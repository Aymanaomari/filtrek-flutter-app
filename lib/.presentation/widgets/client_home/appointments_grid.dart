import 'package:filtrek_app/core/constant/end_points.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/client_home/client_home_screen_provider.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppointmentsGrid extends ConsumerWidget {
  const AppointmentsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final clientHomeState = ref.watch(clientHomeScreenManagerProvider);
    final notifier = ref.read(clientHomeScreenManagerProvider.notifier);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: clientHomeState.appointments.length + 1, // +1 for Add card
      itemBuilder: (context, index) {
        if (index == clientHomeState.appointments.length) {
          // Add Appointment card
          return GestureDetector(
              onTap: () {
                context.pushNamed(RouteNames.chooseCoachAppointment);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colors.secondary,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: colors.primary, size: 32),
                      SizedBox(height: 8),
                      Text("Add Appointment", style: AppTypography.body2),
                    ],
                  ),
                ),
              ));
        }
        // Regular appointment card
        final appointment = clientHomeState.appointments[index];
        String _formatProfilePictureUrl(String id) {
          if (id.isEmpty || id == 'null') {
            // Use a valid anonymous image URL
            return 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
          }
          if (id.startsWith('http://') || id.startsWith('https://')) {
            return id;
          }
          return "${EndPoints.endPointsPrefix}/api/user/profile-picture/$id";
        }

        String _formatDate(DateTime date) {
          return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
        }

        String _formatTime(DateTime date) {
          return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colors.secondary,
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      _formatProfilePictureUrl(appointment.coachProfile),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.open_in_new, color: colors.outline),
                ],
              ),
              Spacer(),
              Text(_formatDate(appointment.startTime),
                  style: AppTypography.body2),
              Text(_formatTime(appointment.startTime),
                  style: AppTypography.body1),
            ],
          ),
        );
      },
    );
  }
}
