part of 'student_list_cubit.dart';

@immutable
sealed class StudentListState {}

final class StudentListInitial extends StudentListState {}
final class StudentListLoaded extends StudentListState {
  final List<UserProfile> userProfile;

  StudentListLoaded({required this.userProfile});
}
