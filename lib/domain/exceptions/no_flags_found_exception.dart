class NoFlagsFoundException implements Exception {
  final String message = 'No Flags found';

  @override
  String toString() {
    return message;
  }
}
