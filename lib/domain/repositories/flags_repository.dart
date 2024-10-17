import 'package:either_dart/either.dart';
import 'package:wonk_app/domain/exceptions/no_flags_found_exception.dart';

import '../models/flags.dart';

abstract class FlagsRepository {
  Future<Either<NoFlagsFoundException, List<Flags>>> getFlags(BigInt storeId);
}
