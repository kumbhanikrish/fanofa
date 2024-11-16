import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthRepository extends BaseRepository {
  AuthRepository({required super.dio});


}
