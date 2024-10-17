import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wonk_app/domain/exceptions/no_califications_found_exception.dart';
import 'package:wonk_app/domain/models/califications.dart';
import 'package:wonk_app/domain/models/supadart_header.dart';
import 'package:wonk_app/domain/repositories/califications_repository.dart';
import 'package:wonk_app/domain/services/client_service.dart';

@Injectable(as: CalificationsRepository)
class CalificationsRepositoryImpl implements CalificationsRepository {
  final SupabaseClient supabase;

  @factoryMethod
  factory CalificationsRepositoryImpl.create(ClientService clientService) {
    return CalificationsRepositoryImpl(supabase: clientService.client);
  }

  CalificationsRepositoryImpl({required this.supabase});

  @override
  Future<Either<Exception, bool>> addCalification(Map<String, dynamic> calification) async {
    try {
      await supabase.califications.insert(calification);

      return const Right(true);
    } catch (e) {
      return Left(Exception('Error adding calification'));
    }
  }

  @override
  Future<Either<NoCalificationsFoundException, List<Califications>>> getCalifications(BigInt storeId) async {
    try {
      final response = await supabase.califications.select().eq(Califications.c_cafeId, storeId).withConverter(Califications.converter);

      return Right(response);
    } catch (e) {
      return Left(NoCalificationsFoundException());
    }
  }
}
