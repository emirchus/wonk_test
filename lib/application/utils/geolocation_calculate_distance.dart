import 'dart:math';

double calculateDistance(double userLatitude, double userLongitude, double storeLatitude, double storeLongitude) {
  const earthRadius = 6371.0;
  final lat1 = userLatitude * (3.1415 / 180);
  final lon1 = userLongitude * (3.1415 / 180);
  final lat2 = storeLatitude * (3.1415 / 180);
  final lon2 = storeLongitude * (3.1415 / 180);
  final dlat = lat2 - lat1;
  final dlon = lon2 - lon1;
  final a = (dlat / 2) * (dlat / 2) + lat1 * lat2 * (dlon / 2) * (dlon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final distance = earthRadius * c;
  return distance;
}
