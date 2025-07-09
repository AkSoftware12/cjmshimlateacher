import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'attendance_report.dart';
import 'mark_attendance.dart';

class AttendanceTabScreen extends StatelessWidget {
  const AttendanceTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.sp),
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(00),
                ),
              ),
              bottom: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 0,
                labelColor: Colors.blueGrey,
                unselectedLabelColor: Colors.blueGrey,
                labelPadding: EdgeInsets.all(0),
                labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                tabs: [
                  Tab(text: "Mark Attendance".toUpperCase()),
                  Tab(text: "Report Attendance".toUpperCase()),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 5), // Bottom padding
          child: TabBarView(
            children: [
              AttendanceScreen(),
              MonthlyAttendanceScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
