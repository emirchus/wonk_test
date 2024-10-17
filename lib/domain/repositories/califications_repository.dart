import 'package:either_dart/either.dart';
import 'package:wonk_app/domain/exceptions/no_califications_found_exception.dart';
import 'package:wonk_app/domain/models/califications.dart';

abstract class CalificationsRepository {
  Future<Either<NoCalificationsFoundException, List<Califications>>> getCalifications(BigInt storeId);

  Future<Either<Exception, bool>> addCalification(Map<String, dynamic> calification);
}
