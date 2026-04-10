import 'package:flutter/material.dart';

class HoritzontalDateScroller extends StatefulWidget {
  const HoritzontalDateScroller({super.key});

  @override
  State<HoritzontalDateScroller> createState() =>
      _HoritzontalDateScrollerState();
}

class _HoritzontalDateScrollerState extends State<HoritzontalDateScroller> {
  int selectedIndex = 0;
  List<DateTime> dates = [];

  @override
  void initState() {
    super.initState();
    _generateDates();
  }

  void _generateDates() {
    final now = DateTime.now();
    dates.clear();

    // Generate 15 dates starting from today
    for (int i = 0; i < 15; i++) {
      dates.add(now.add(Duration(days: i)));
    }
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _getFormattedDay(DateTime date) {
    return date.day.toString().padLeft(2, '0');
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Return empty container if dates are not loaded yet
    if (dates.isEmpty) {
      return Container(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 32; // 16 * 2 for horizontal padding
    final totalMargin = 56; // 4 * 2 * 7 for margins between items
    final itemWidth = (screenWidth - padding - totalMargin) /
        7; // Width to fit 7 items on screen

    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15, // Show 15 days
        itemBuilder: (context, index) {
          // Safety check to prevent index out of bounds
          if (index >= dates.length) return SizedBox.shrink();

          bool isSelected = selectedIndex == index;
          bool isToday = _isToday(dates[index]);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              width: itemWidth,
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? colors.primary
                      : isToday
                          ? colors.primary.withOpacity(0.5)
                          : colors.outline.withOpacity(0.3),
                  width: isToday ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(dates[index]),
                    style: TextStyle(
                      color: isSelected
                          ? colors.onPrimary
                          : isToday
                              ? colors.primary
                              : colors.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _getFormattedDay(dates[index]),
                    style: TextStyle(
                      color: isSelected
                          ? colors.onPrimary
                          : isToday
                              ? colors.primary
                              : colors.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
