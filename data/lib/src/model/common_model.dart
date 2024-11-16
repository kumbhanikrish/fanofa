part of 'model.dart';

class Language extends Equatable {
  final String name;
  final String code;

  const Language({
    required this.name,
    required this.code,
  });

  @override
  List<Object?> get props => [name, code];
}

class SortListData {
  final int id;
  final String name;

  const SortListData({
    required this.id,
    required this.name,
  });
}
