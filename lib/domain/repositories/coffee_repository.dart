import 'package:either_dart/either.dart';
import 'package:wonk_app/domain/exceptions/exceptions.dart';
import 'package:wonk_app/domain/models/models.dart';

abstract class CoffeeRepository {
  Future<Either<NoCoffeesFoundException, List<Cafes>>> getCoffees();

  Future<Either<NoCoffeesFoundException, List<Cafes>>> getCoffeeByLatLng(double lat, double lng);

  Future<Either<NoCoffeesFoundException, Cafes>> getCoffeeById(BigInt id);

  Future<void> markAsFavorite(BigInt storeId);

  Future<void> removeFavorite(BigInt storeId);
}
