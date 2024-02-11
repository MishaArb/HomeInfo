abstract class RequestResult<T>{
  final T? data;
  final String? errorMessage;

  RequestResult({this.data, this.errorMessage});
}

class RequestSuccess<T> extends RequestResult<T>{
  RequestSuccess(T data) : super(data: data);
}

class RequestError<T> extends RequestResult<T>{
  RequestError(String errorMessage) : super(errorMessage: errorMessage);
}