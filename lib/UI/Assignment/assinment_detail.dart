import 'package:cjmshimlateacher/UI/Assignment/view_assignment_detail.dart';
import 'package:cjmshimlateacher/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentDetailScreen extends StatefulWidget {
  final int id;

  const AssignmentDetailScreen({super.key, required this.id});

  @override
  _AssignmentDetailScreenState createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  Future<Map<String, dynamic>> fetchAssignment(int assignmentId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${ApiRoutes.getAssignmentsDeatils}$assignmentId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load assignment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchAssignment(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                  SizedBox(height: 16),
                  Text("Loading Assignment...",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!['success'] != true) {
            return const Center(
              child: Text(
                "No Assignment Found",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }

          final data = snapshot.data!['data'];
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 150.sp,
                // Slightly taller for better effect
                floating: false,
                pinned: true,
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    data['title'].toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/assignment_icon_img.png'),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.8)],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                backgroundColor: Colors.black,
                elevation: 4,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Assignment Details Card
                      Card(
                        color: Colors.grey.shade50,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        margin: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            // gradient: const LinearGradient(
                            //   colors: [Colors.purple, Colors.deepPurpleAccent],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          padding: EdgeInsets.all(10.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Start : ${data['start_date']}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Due  : ${data['end_date']}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Chip(
                                    label: Text(
                                      "Marks: ${data['total_marks']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                ],
                              ),
                              Text(
                                data['description'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      // Students Section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Students",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Chip(
                              label: Text("${data['students'].length} Students",
                                  style: const TextStyle(color: Colors.white)),
                              backgroundColor: Colors.purple,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final student = data['students'][index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      child: SizedBox(
                        width: 100.sp, // Set card width
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blueAccent.shade100,
                                  child: Text(
                                    student['student_name'][0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            student['student_name'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          Container(
                                            height: 30.sp,
                                            width: 90.sp,
                                            decoration:  BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 10.sp,right: 10.sp),
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: 'Enter marks',
                                                  // labelText: "Enter Marks",
                                                  hintStyle: TextStyle(fontSize: 10.sp),
                                                  border:InputBorder.none
                                                ),
                                                style: TextStyle(fontSize: 10.sp),

                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.grade,
                                              size: 18,
                                              color: Colors.orangeAccent),
                                          const SizedBox(width: 6),
                                          Text(
                                              "Marks: ${student['marks'] ?? 'N/A'}",
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 18,
                                            color: student['attendance'] == 1
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Attendance: ${student['attendance'] == 1 ? 'Present' : 'Absent'}",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text("Date: ${student['date'] ?? 'N/A'}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54)),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                if (student['attach_url'] != null)
                                  IconButton(
                                    icon: const Icon(Icons.attach_file,
                                        color: Colors.blue),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => WebViewPage(
                                      //           url: student['attach_url']
                                      //           )),
                                      // );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: data['students'].length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
