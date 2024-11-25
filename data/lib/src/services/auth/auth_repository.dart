import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthRepository extends BaseRepository {
  AuthRepository({required super.dio});

  Stream<DataEvent<dynamic>> register({
    required String fullName,
    required String phoneNumber,
  }) async* {
    final request = ApiRequest<dynamic>(RequestType.post, "/users/signup")
      ..data = {
        "full_name": fullName,
        "phone_number": phoneNumber,
      }
      ..responseParser = (value) => value;
    yield* processApi(request);
  }

}
