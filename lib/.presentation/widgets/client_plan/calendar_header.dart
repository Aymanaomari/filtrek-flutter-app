import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/providers/managers/client_plan/client_plan_screen_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHeader extends ConsumerStatefulWidget {
  const CalendarHeader({super.key});

  @override
  ConsumerState<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends ConsumerState<CalendarHeader> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.enforced;
  DateTime _focusedDay = DateTime.now();
  final kFirstDay = DateTime.utc(2020, 1, 1);
  final kLastDay = DateTime.utc(2030, 12, 31);

  @override
  Widget build(BuildContext context) {
    final clientPlanNotifier =
        ref.read(clientPlanScreenManagerProvider.notifier);
    final clientPlanState = ref.watch(clientPlanScreenManagerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusedDay != clientPlanState.selectedDate) {
        setState(() {
          _focusedDay = clientPlanState.selectedDate;
        });
      }
    });

    return Container(
      padding: const EdgeInsets.only(top: 24),
      alignment: Alignment.center,
      height: 30.0.hp(context).clamp(240, 260),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).secondary,
        image: DecorationImage(
          image: AssetImage(ImageAssets.homeSubscribtionCardBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              _buildHeaderText(context),
              const SizedBox(height: 8),
              Expanded(
                  child: _buildCalendar(
                      context, clientPlanNotifier, clientPlanState)),
            ],
          ),
          _buildBottomDecoration(context),
        ],
      ),
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    return Text(
      'My planing',
      style: AppTypography.h1.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, dynamic clientPlanNotifier,
      dynamic clientPlanState) {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: ColorScheme.of(context).onSecondary),
      ),
      firstDay: kFirstDay,
      lastDay: kLastDay,
      currentDay: DateTime.now(),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) =>
          isSameDay(clientPlanState.selectedDate, day),
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: AppTypography.button.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w800,
        ),
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        todayTextStyle: AppTypography.button.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w800,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: AppTypography.subtitle1.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      daysOfWeekHeight: 24,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(clientPlanState.selectedDate, selectedDay)) {
          setState(() {
            _focusedDay = focusedDay;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
          clientPlanNotifier.setSelectedDate(selectedDay);
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  Widget _buildBottomDecoration(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 16,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
    );
  }
}
