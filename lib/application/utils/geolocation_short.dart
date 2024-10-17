import 'package:wonk_app/application/utils/geolocation_calculate_distance.dart';
import 'package:wonk_app/domain/models/cafes.dart';

List<Cafes> sortStoresByDistance(List<Cafes> stores, double userLatitude, double userLongitude) {
  stores.sort((a, b) {
    final distanceA = calculateDistance(userLatitude, userLongitude, a.location!.lat, a.location!.lng);
    final distanceB = calculateDistance(userLatitude, userLongitude, b.location!.lat, b.location!.lng);
    return distanceA.compareTo(distanceB);
  });
  return stores;
}
