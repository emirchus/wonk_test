const Map<String, CalificationsType> _values = {
  'ambiental': CalificationsType.ambiental,
  'coffe': CalificationsType.coffe,
  'connectivity': CalificationsType.connectivity,
  'lights': CalificationsType.lights,
};

enum CalificationsType {
  ambiental('ambiental'),
  coffe('coffe'),
  connectivity('connectivity'),
  lights('lights');

  final String value;

  const CalificationsType(this.value);

  static CalificationsType fromValue(String value) {
    return _values[value]!;
  }
}
