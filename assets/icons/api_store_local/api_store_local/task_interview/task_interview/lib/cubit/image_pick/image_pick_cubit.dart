import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageCubit extends Cubit<File?> {
  ImageCubit() : super(null);

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(File(pickedFile.path));
      } else {
        emit(null);
      }
    } catch (e) {
      emit(null);
    }
  }

  init() {
    emit(null);
  }
}

class GenderCubit extends Cubit<String> {
  GenderCubit() : super('');

  void updateGender(String newGender) {
    emit(newGender);
  }

  init() {
    emit('');
  }
}
