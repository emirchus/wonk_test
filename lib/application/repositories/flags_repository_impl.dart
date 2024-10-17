import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wonk_app/domain/exceptions/no_flags_found_exception.dart';
import 'package:wonk_app/domain/models/flags.dart';
import 'package:wonk_app/domain/models/supadart_header.dart';
import 'package:wonk_app/domain/repositories/flags_repository.dart';
import 'package:wonk_app/domain/services/client_service.dart';

@Injectable(as: FlagsRepository)
class FlagsRepositoryImpl implements FlagsRepository {
  final SupabaseClient supabase;

  @factoryMethod
  factory FlagsRepositoryImpl.create(ClientService clientService) {
    return FlagsRepositoryImpl(supabase: clientService.client);
  }

  FlagsRepositoryImpl({required this.supabase});

  @override
  Future<Either<NoFlagsFoundException, List<Flags>>> getFlags(BigInt storeId) async {
    try {
      final response = await supabase.flags.select().eq(Flags.c_cafeId, storeId).withConverter(Flags.converter);

      return Right(response);
    } catch (_) {
      return Left(NoFlagsFoundException());
    }
  }
}
