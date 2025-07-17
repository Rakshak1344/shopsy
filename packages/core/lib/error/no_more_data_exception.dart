class NoMoreDataException implements Exception {
  final String message;

  NoMoreDataException([this.message = 'No more products available.']);

  @override
  String toString() => 'NoMoreDataException: $message';
}
