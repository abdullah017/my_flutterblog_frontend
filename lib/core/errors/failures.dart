// lib/core/error/failures.dart
abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Sunucu ile bağlantı kurulamadı.');
}

class CacheFailure extends Failure {
  CacheFailure() : super('Veri önbellekten alınamadı.');
}
