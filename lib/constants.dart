import 'package:flutter/material.dart';

import 'HexColorCode/HexColor.dart';

class AppColors {
  // static const Color primary = Color(0xFF041B7F); // Example primary color (blue)
  static  Color primary = HexColor('#f5f1e0'); // Example primary color (blue)
  static  Color secondary =HexColor('#7da4d1'); // Secondary color (gray)
  // static const Color secondary = Color(0xFF074799); // Secondary color (gray)
  static const Color grey = Color(0xFFAAAEB2); // Secondary color (gray)
  static const Color background = Color(0xFFF8F9FA); // Light background color
  static const Color textblack = Color(0xFF212529); // Dark text color
    static const Color textwhite = Color.fromARGB(255, 255, 255, 255); // Dark text color
    // static  Color textwhite = Colors.grey.shade500; // Dark text color
  static const Color error = Color(0xFFDC3545); // Error color (red)
  static const Color success = Color(0xFF28A745); // Success color (green)
  static const Color yellow = Color(0xFFCCAB21); // Success color (green)
}

class AppAssets {
  static const String logo = 'assets/images/logo.png'; 
  static const String cjm = 'assets/cjm.png';
  static const String cjmlogo = 'assets/playstore.png';
}

class ApiRoutes {

// Gallery App url
  static const String baseUrl2 = "https://webcjm.cjmshimla.in/api";


  // Main App Url
  static const String baseUrl = "https://testapi.cjmshimla.in/api";
  // static const String baseUrl = "https://apicjm.cjmshimla.in/api";



  // Local App url
  // static const String baseUrl = "http://192.168.1.4/cjm_shimla/api";



  static const String login = "$baseUrl/teacher-login";
  static const String getProfile = "$baseUrl/teacher";
  static const String getPhotos = "$baseUrl2/getPhotos";
  static const String getVideos = "$baseUrl2/getVideos";
  static const String uploadAssignment = "$baseUrl/teacher-assignment";
  static const String deleteAssignment = "$baseUrl/teacher-assignment-delete";
  static const String getDashboard = "$baseUrl/dashboard";
  static const String getFees = "$baseUrl/get-fees";
  static const String getAssignments = "$baseUrl/teacher-assignment";
  static const String getAssignmentsDeatils = "$baseUrl/teacher-assignment/";
  // static const String getTimeTable = "$baseUrl/teacher-subjects";
  static const String getTimeTable = "$baseUrl/teacher-timetable?day=";
  static const String getSubject = "$baseUrl/get-subjects";
  static const String studentDashboard = "$baseUrl/dashboard";
  static const String attendance = "$baseUrl/get-attendance-monthly";
  static const String events = "$baseUrl/events";
  static const String getBanners = "$baseUrl/get-banners";
  static const String notifications = "$baseUrl/teacher-notifications";
  static const String getClass = "$baseUrl/teacher-student-atttendance";
  static const String getTeacherSubject = "$baseUrl/teacher-assigned-subjects";
  static const String getlibrary = "$baseUrl/library-get";
  static const String getBookTypes = "$baseUrl/book-types";
  static const String getBookCategories = "$baseUrl/book-categories";
  static const String getBookPublishers = "$baseUrl/book-publishers";
  static const String getBookSupplier= "$baseUrl/book-supplier";
}
