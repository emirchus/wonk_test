import 'package:latlong2/latlong.dart';

enum ExpansionRadius {
  km(1000),
  m(1);

  final double radius;

  const ExpansionRadius(this.radius);
}

(LatLng, LatLng) expandRadius(
  double lat,
  double lng,
  double radius,
) {
  final expandedRadius = modifyRadius(lat, lng, radius);
  final reducedRadius = modifyRadius(lat, lng, radius, reduce: true);

  return (LatLng(expandedRadius.$1, expandedRadius.$2), LatLng(reducedRadius.$1, reducedRadius.$2));
}

(double, double) modifyRadius(double lat, double lng, double radius, {bool reduce = false}) {
  final newRadius = radius / 111.0;
  if (reduce) {
    return (lat - newRadius, lng - newRadius);
  }
  return (lat + newRadius, lng + newRadius);
}
