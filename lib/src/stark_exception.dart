class StarkException implements Exception {
  StarkException(this.message);
  String message;

  @override
  String toString() => 'Injector Exception: $message';
}
