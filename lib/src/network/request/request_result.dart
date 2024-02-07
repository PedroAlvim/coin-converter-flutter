class RequestResult<T> {
  RequestResult({
    required this.successful,
    this.data,
    this.exception,
  });

  final bool successful;
  final T? data;
  final Exception? exception;

  T get requireData {
    if (data != null) return data!;

    throw StateError('No data');
  }
}