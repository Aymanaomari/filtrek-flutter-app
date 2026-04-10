import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/choose_time/choose_time_screen_manager_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ChooseTimeCalendar extends ConsumerWidget {
  final String coachId;
  const ChooseTimeCalendar({super.key, required this.coachId});

  DateTime _parseDateString(String date) {
    final parts = date.split('-');
    return DateTime(
      int.parse(parts[0]), // year
      int.parse(parts[1]), // month
      int.parse(parts[2]), // day
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final chooseTimeNotifier =
        ref.read(chooseTimeScreenManagerProvider(coachId).notifier);
    final chooseTimeState = ref.watch(chooseTimeScreenManagerProvider(coachId));

    final selectedDate = chooseTimeState.appointmentRequest != null
        ? _parseDateString(chooseTimeState.appointmentRequest!.date)
        : DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM , yyyy').format(
                  DateTime(selectedDate.year, selectedDate.month),
                ),
                style: AppTypography.h3.copyWith(color: colors.onSecondary),
              ),
              Row(
                spacing: 8,
                children: [
                  MaterialButton(
                    color: colors.secondary,
                    onPressed: chooseTimeNotifier.goToPreviousMonth,
                    child: Icon(Icons.arrow_back, size: 20),
                    minWidth: 40,
                    height: 52,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  MaterialButton(
                    color: colors.secondary,
                    onPressed: chooseTimeNotifier.goToNextMonth,
                    child: Icon(Icons.arrow_forward, size: 20),
                    minWidth: 40,
                    height: 52,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 24),
          TableCalendar(
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle:
                    AppTypography.body2.copyWith(color: colors.tertiary),
                weekendStyle:
                    AppTypography.body2.copyWith(color: colors.tertiary)),
            daysOfWeekHeight: 56,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: colors.primary.withOpacity(0.15),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.15),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              todayTextStyle: AppTypography.body1
                  .copyWith(color: colors.surface, fontWeight: FontWeight.w500),
              selectedDecoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              selectedTextStyle: AppTypography.body1
                  .copyWith(color: colors.surface, fontWeight: FontWeight.w500),
            ),
            calendarFormat: CalendarFormat.month,
            headerVisible: false,
            rowHeight: 56,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: chooseTimeState.focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onPageChanged: (focusedDay) {
              chooseTimeNotifier.setFocusedDay(focusedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              chooseTimeNotifier.setSelectedDate(selectedDay);
            },
            enabledDayPredicate: (day) {
              final now = DateTime.now();
              return !day.isBefore(DateTime(now.year, now.month, now.day));
            },
          ),
        ],
      ),
    );
  }
}
