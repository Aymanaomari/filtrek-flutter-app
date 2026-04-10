import 'package:filtrek_app/presentation/providers/managers/client_plan/client_plan_screen_manager.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Placeholder calendar widget for client plan view
/// This widget can be replaced with a different calendar implementation in the future
class CustomClientSfcalendar extends ConsumerStatefulWidget {
  const CustomClientSfcalendar({super.key});

  @override
  ConsumerState<CustomClientSfcalendar> createState() =>
      _CustomClientSfcalendarState();
}

class _CustomClientSfcalendarState
    extends ConsumerState<CustomClientSfcalendar> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final clientPlanNotifier =
        ref.read(clientPlanScreenManagerProvider.notifier);
    final clientPlanState = ref.watch(clientPlanScreenManagerProvider);

    if (clientPlanState.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: color.surface,
            border: Border.all(
              color: color.outline.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 48,
                  color: color.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Client Calendar View',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: color.onSurface,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'View and manage your appointments',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color.outline,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (clientPlanState.appointments.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${clientPlanState.appointments.length} appointments',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.primary.withOpacity(0.3),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              onPressed: () {
                context.pushNamed(RouteNames.chooseCoachAppointment);
              },
              backgroundColor: color.primary,
              child: const Icon(
                Icons.add,
                weight: 24,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
