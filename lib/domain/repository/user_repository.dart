import '../../application/service/result.dart';
import '../entity/error.dart';
import '../entity/user_entity.dart';

abstract interface class UserRepository {
  Future<Result<Exception, UserEntity>> getUser();
}