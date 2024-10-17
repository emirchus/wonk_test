class NoCoffeesFoundException implements Exception {
  final String message = 'No coffees found';

  @override
  String toString() {
    return message;
  }
}
