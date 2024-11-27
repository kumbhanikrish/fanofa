import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:task_interview/main.dart';
import 'package:task_interview/service/model/student_list_model.dart';
import 'package:task_interview/service/db_helper.dart';

part 'student_list_state.dart';

class StudentListCubit extends Cubit<StudentListState> {
  StudentListCubit() : super(StudentListInitial());

  void init() {
    emit(StudentListInitial());
  }

  Future<List<UserProfile>> fetchData() async {
    DBHelper dbHelper = DBHelper();
    Map<String, dynamic> data = {
      'parent_id': 19656,
      'bp_designation': 58,
      'bp_tal_id': 'SCLT_00658',
      'company_id': '4780705636970E3034CA6C753777FD0B',
    };
    Response response = await apiRepository.sendFormData(
      url: 'https://staging-api.traceablegiving.org/data/student_list_new',
      data: data,
    );

    List<UserProfile> userProfile = [];

    userProfile = (response.data['response'] as List)
        .map((e) => UserProfile.fromJson(e))
        .toList();

    for (var user in userProfile) {
      await dbHelper.insertStudent(user.toJson());
    }
    loadFromDB();

    return userProfile;
  }

  Future<Response> updateStudentData(
      {required Map<String, dynamic> data}) async {
    DBHelper dbHelper = DBHelper();

    Response response = await apiRepository.sendFormData(
      url: 'https://staging-api.traceablegiving.org/data/get_data_all_new',
      data: data,
    );

    List<UserProfile> userProfile = [];

    userProfile = (state as StudentListLoaded).userProfile;

    for (var user in userProfile) {
      if (user.bpId == data['bp_id']) {
        log('sdfsdf ::${user.bpId == data['bp_id']}');
        Map<String, dynamic> datadata = {
          'bp_id': data['bp_id'],
          'bp_fname': data['bp_fname'],
          'bp_mname': data['bp_mname'],
          'bp_lname': data['bp_lname'],
          'bp_email': data['bp_email'],
          'bp_gender': data['bp_gender'],
          'bp_mobile_no': data['bp_mobile_no'],
        };

        await dbHelper.updateUserProfile(data: datadata);

        user.bpFname = data['bp_fname'];
        user.bpFname = data['bp_mname'];
        user.bpFname = data['bp_lname'];
        user.bpFname = data['bp_email'];
        user.bpFname = data['bp_gender'];
      }
    }
    loadFromDB();

    return response;
  }

  Future<List<UserProfile>> loadFromDB() async {
    final dbHelper = DBHelper();
    List<Map<String, dynamic>> students = await dbHelper.fetchStudents();
    List<UserProfile> userProfile =
        students.map((e) => UserProfile.fromJson(e)).toList();
    emit(StudentListLoaded(userProfile: userProfile));
    log("fetchData:: ${json.encode(userProfile)}");
    return userProfile;
  }
}
