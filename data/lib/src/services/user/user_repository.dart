import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart' as mime;

@LazySingleton()
class UserRepository extends BaseRepository {
  UserRepository({required super.dio});
}
