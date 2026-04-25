enum NetworkResponseType {
  success,
  notFound,
  error,
  unAuthorized,
  conflict,
  tokenExpired,
  notApproved,
  invalid,
}

class NetworkResponse<T> {
  final NetworkResponseType type;
  final String message;
  final T? data;

  NetworkResponse({required this.type, this.message = '', this.data});
}
