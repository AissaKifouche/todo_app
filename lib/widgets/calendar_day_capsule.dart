import 'package:flutter/material.dart';


class CalendarDayCapsule extends StatelessWidget {
  final String dayLabel;
  final String dateLabel;
  final bool isSelected;

  const CalendarDayCapsule({
    super.key,
    required this.dayLabel,
    required this.dateLabel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Custom vertical padding to make the pill capsule look oblong when selected
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF003F83).withValues(alpha: 0.69) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12), // Spacing between day name and day number
          Text(
            dateLabel,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}