import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_interview/cubit/student_list/student_list_cubit.dart';
import 'package:task_interview/custom_widget/custom_widget.dart';
import 'package:task_interview/page_name/page_name.dart';
import 'package:task_interview/service/model/student_list_model.dart';

class StudentListScreen extends StatelessWidget {
  StudentListScreen({Key? key}) : super(key: key);

  List<UserProfile> userProfileList = [];

  @override
  Widget build(BuildContext context) {
    StudentListCubit studentListCubit =
        BlocProvider.of<StudentListCubit>(context);
    return Scaffold(
      appBar: customAppBar(
        text: 'Student List',
      ),
      body: BlocBuilder<StudentListCubit, StudentListState>(
        builder: (context, state) {
          if (state is! StudentListLoaded) {
            studentListCubit.fetchData();

            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            userProfileList = state.userProfile;

            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.separated(
                itemCount: userProfileList.length,
                itemBuilder: (BuildContext context, int index) {
                  UserProfile userProfile = userProfileList[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          updateStudentScreen,
                          arguments: {
                            'userProfile': userProfile,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text:
                                  '${userProfile.bpFname} ${userProfile.bpMname} ${userProfile.bpLname}',
                              color: Colors.black,
                            ),
                            customText(
                              text: userProfile.bpTalId,
                              color: Colors.black,
                            ),
                            titleAndText(
                              title: 'Mo No',
                              text: userProfile.bpMobileNo,
                            ),
                            if (userProfile.bpEmail.isNotEmpty) ...[
                              titleAndText(
                                title: 'Email',
                                text: userProfile.bpEmail,
                              ),
                            ],
                            titleAndText(
                              title: 'Gender',
                              text: userProfile.bpGender,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Gap(10);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
