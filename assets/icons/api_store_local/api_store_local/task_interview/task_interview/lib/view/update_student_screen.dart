import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:task_interview/cubit/image_pick/image_pick_cubit.dart';
import 'package:task_interview/cubit/student_list/student_list_cubit.dart';
import 'package:task_interview/custom_widget/custom_widget.dart';
import 'package:task_interview/service/model/student_list_model.dart';

class UpdateStudentScreen extends StatelessWidget {
  final dynamic data;
  UpdateStudentScreen({Key? key, this.data}) : super(key: key);
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController mNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController moNoNameController = TextEditingController();
  String gender = '';
  File? file;
  @override
  Widget build(BuildContext context) {
    UserProfile userProfile = data['userProfile'];

    StudentListCubit studentListCubit =
        BlocProvider.of<StudentListCubit>(context);
    ImageCubit imageCubit = BlocProvider.of<ImageCubit>(context);
    GenderCubit genderCubit = BlocProvider.of<GenderCubit>(context);

    fNameController.text = userProfile.bpFname;
    mNameController.text = userProfile.bpMname;
    lNameController.text = userProfile.bpLname;
    emailNameController.text = userProfile.bpEmail;
    moNoNameController.text = userProfile.bpMobileNo;
    gender = userProfile.bpGender;

    log('userProfile.bpGenderuserProfile.bpGender ::${userProfile.bpGender}');
    genderCubit.updateGender(gender);

    imageCubit.init();
    return Scaffold(
      appBar: customAppBar(
          text: 'Update Student',
          leading: customIconButton(
            icon: Icons.arrow_back_ios_new,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    color: Colors.red),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    title: customText(
                      text: 'STUDENT INFORMATION',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            customText(
                              text: 'Profile Picture *',
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            Gap(10),
                            BlocBuilder<ImageCubit, File?>(
                              builder: (context, state) {
                                file = state;
                                return GestureDetector(
                                  onTap: () {
                                    imageCubit.pickImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: state != null
                                        ? FileImage(file ?? File(''))
                                        : null,
                                    child: file == null
                                        ? const Icon(Icons.person,
                                            size: 60, color: Colors.grey)
                                        : null,
                                  ),
                                );
                              },
                            ),
                            Gap(10),
                            customTextFormFiled(
                              hintText: 'First Name *',
                              controller: fNameController,
                            ),
                            Gap(10),
                            customTextFormFiled(
                              hintText: 'Middle Name *',
                              controller: mNameController,
                            ),
                            Gap(10),
                            customTextFormFiled(
                              hintText: 'Last Name *',
                              controller: lNameController,
                            ),
                            Gap(10),
                            customTextFormFiled(
                              hintText: 'Email Name *',
                              controller: emailNameController,
                            ),
                            Gap(10),
                            customTextFormFiled(
                              hintText: 'Mobile Number *',
                              controller: moNoNameController,
                            ),
                            BlocBuilder<GenderCubit, String>(
                              builder: (context, state) {
                                gender = state;
                                return Row(
                                  children: [
                                    Expanded(
                                        child: customRadioListView(
                                      text: 'Male',
                                      value: 'Male',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        genderCubit.updateGender(value);
                                      },
                                    )),
                                    Expanded(
                                      child: customRadioListView(
                                        text: 'Female',
                                        value: 'Female',
                                        groupValue: gender,
                                        onChanged: (value) {
                                          genderCubit.updateGender(value);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () async {
            Map<String, dynamic> data = {
              'parent_id': 19656,
              'bp_id': userProfile.bpId,
              'bp_fname': fNameController.text,
              'bp_mname': mNameController.text,
              'bp_lname': lNameController.text,
              'bp_email': emailNameController.text,
              'bp_gender': gender,
              'company_id': '4780705636970E3034CA6C753777FD0B',
              'bp_tal_id': 'SCLT_00658',
              'bp_mobile_no': moNoNameController.text,
              'bk_profile': file != null
                  ? await MultipartFile.fromFile(
                      file?.path ?? '',
                      filename: file?.path.split('/').last,
                    )
                  : null,
            };

            log(';datadatadata ::${userProfile.bpId}');
            context.loaderOverlay.show();

            studentListCubit.updateStudentData(data: data).then(
              (e) {
                if (e.data['errorMessage'] == 'Success') {
                  context.loaderOverlay.hide();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: customText(
                        text: e.data['errorMessage'],
                      ),
                    ),
                  );
                } else {
                  context.loaderOverlay.hide();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: customText(
                        text: e.data['errorMessage'],
                      ),
                    ),
                  );
                }
              },
            );
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.red,
          ),
          child: customText(
              text: 'Update',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }
}
