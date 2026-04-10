import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ChooseTimeAppointmentScreen extends StatefulWidget {
  const ChooseTimeAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<ChooseTimeAppointmentScreen> createState() =>
      _ChooseTimeAppointmentScreenState();
}

class _ChooseTimeAppointmentScreenState
    extends State<ChooseTimeAppointmentScreen> {
  DateTime _focusedDay = DateTime.now();

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay =
          DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay =
          DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${_focusedDay.month}/${_focusedDay.year}"),
                Row(
                  children: [
                    MaterialButton(
                      color: colors.secondary,
                      onPressed: _goToPreviousMonth,
                      child: Icon(Icons.arrow_back, size: 16),
                      minWidth: 40,
                      height: 48,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    MaterialButton(
                      color: colors.secondary,
                      onPressed: _goToNextMonth,
                      child: Icon(Icons.arrow_forward, size: 16),
                      minWidth: 40,
                      height: 48,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ],
                )
              ],
            ),
            TableCalendar(
              calendarFormat: CalendarFormat.month,
              headerVisible: false,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
