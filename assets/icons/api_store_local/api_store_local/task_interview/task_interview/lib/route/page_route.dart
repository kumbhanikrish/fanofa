import 'package:flutter/material.dart';
import 'package:task_interview/page_name/page_name.dart';
import 'package:task_interview/view/student_list_screen.dart';
import 'package:task_interview/view/update_student_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  studentListScreen: (context) => StudentListScreen(),
  updateStudentScreen: (context) => UpdateStudentScreen(
        data: ModalRoute.of(context)?.settings.arguments,
      ),
};
