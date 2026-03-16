 class ServerError implements Exception{
  final String errorMessage;

  ServerError({required this.errorMessage});
}

 class NetworkError implements Exception{
  final String errorMessage;

  NetworkError({required this.errorMessage});
}