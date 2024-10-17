class NoCalificationsFoundException implements Exception {
  final String message = 'No Califications found';

  @override
  String toString() {
    return message;
  }
}
