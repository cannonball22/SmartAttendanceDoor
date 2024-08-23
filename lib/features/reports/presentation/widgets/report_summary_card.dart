import 'package:flutter/material.dart';

import '../../../../Data/Model/Attendance Report/attendance_report.model.dart';

class ReportSummaryCard extends StatelessWidget {
  final AttendanceReport attendanceReport;

  const ReportSummaryCard({
    super.key,
    required this.attendanceReport,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFF6FAF7),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD0C3CC)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow(
              label: 'Attendance:',
              value: '${attendanceReport.attendance} %',
            ),
            _buildSummaryRow(
              label: 'Class:',
              value: attendanceReport.className,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: _textStyle(),
          ),
          Text(
            value,
            style: _textStyle(),
          ),
        ],
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      color: Color(0xFF4D444C),
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.10,
    );
  }
}
