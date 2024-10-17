import 'package:either_dart/either.dart';
import 'package:wonk_app/domain/exceptions/no_files_exception.dart';

abstract class StorageService {
  Future<Either<NoFilesException, List<String>>> getFilesFromStore(BigInt storeId);
}
