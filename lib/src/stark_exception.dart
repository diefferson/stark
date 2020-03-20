
class StarkException implements Exception {

  String message;

  StarkException(this.message);

  @override
  String toString() => "Injector Exception: ${this.message}";
}