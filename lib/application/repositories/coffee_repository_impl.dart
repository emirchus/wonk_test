import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wonk_app/application/utils/gelocation_radius.dart';
import 'package:wonk_app/domain/exceptions/no_coffes_found_exception.dart';
import 'package:wonk_app/domain/models/cafes.dart';
import 'package:wonk_app/domain/models/hours.dart';
import 'package:wonk_app/domain/models/locations.dart';
import 'package:wonk_app/domain/models/supadart_header.dart';
import 'package:wonk_app/domain/repositories/coffee_repository.dart';
import 'package:wonk_app/domain/services/client_service.dart';

@Injectable(as: CoffeeRepository)
class CoffeeRepositoryImpl implements CoffeeRepository {
  final SupabaseClient supabase;

  @factoryMethod
  factory CoffeeRepositoryImpl.create(ClientService clientService) {
    return CoffeeRepositoryImpl(supabase: clientService.client);
  }

  CoffeeRepositoryImpl({required this.supabase});

  @override
  Future<Either<NoCoffeesFoundException, Cafes>> getCoffeeById(BigInt id) {
    // TODO: implement getCoffeeById
    throw UnimplementedError();
  }

  @override
  Future<Either<NoCoffeesFoundException, List<Cafes>>> getCoffees() async {
    try {
      final response = await supabase.cafes.select(
        """
          *,
          ${Locations.table_name} ( ${Locations.c_cafeId} , * ),
          ${Hours.table_name} ( ${Hours.c_cafeId} , * )
        """,
      ).withConverter(Cafes.converter);

      return Right(response);
    } catch (e) {
      return Left(NoCoffeesFoundException());
    }
  }

  @override
  Future<Either<NoCoffeesFoundException, List<Cafes>>> getCoffeeByLatLng(double lat, double lng) async {
    try {
      final (expanded, reduced) = expandRadius(lat, lng, 10 * ExpansionRadius.m.radius);

      final response = await supabase.cafes
          .select(
            """
              *,
              ${Locations.table_name} ( ${Locations.c_cafeId} , * ),
              ${Hours.table_name} ( ${Hours.c_cafeId} , * )
            """,
          )
          .lte("${Locations.table_name}.${Locations.c_lat}", expanded.latitude)
          .gte("${Locations.table_name}.${Locations.c_lat}", reduced.latitude)
          .lte("${Locations.table_name}.${Locations.c_lng}", expanded.longitude)
          .gte("${Locations.table_name}.${Locations.c_lng}", reduced.longitude)
          .withConverter(Cafes.converter);

      return Right(response);
    } catch (e) {
      return Left(NoCoffeesFoundException());
    }
  }

  @override
  Future<void> markAsFavorite(BigInt storeId) {
    // TODO: implement markAsFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavorite(BigInt storeId) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }
}
