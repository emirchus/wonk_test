class NoFilesException implements Exception {
  final String message;

  NoFilesException(this.message);

  @override
  String toString() {
    return message;
  }
}