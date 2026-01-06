typedef JsonParser<T> = T Function(Map<String, dynamic> json);
class BaseResponse<T> extends ApiResponse<T> {
  final T? data;

  BaseResponse({
    required super.success,
    this.data,
    super.message,
    super.errorMessage,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJsonT,
      ) {
    return BaseResponse<T>(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'],
      errorMessage: json['errorMessage'],
    );
  }
}

class BaseResponseList<T> extends ApiResponse<List<T>> {
  final List<T> data;

  BaseResponseList({
    required super.success,
    required this.data,
    super.message,
    super.errorMessage,
  });

  factory BaseResponseList.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJsonT,
      ) {
    final list = json['data'] as List? ?? [];

    return BaseResponseList<T>(
      success: json['success'] ?? false,
      data: list
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      message: json['message'],
      errorMessage: json['errorMessage'],
    );
  }
}



abstract class ApiResponse<T> {
  final bool success;
  final String? message;
  final String? errorMessage;

  const ApiResponse({
    required this.success,
    this.message,
    this.errorMessage,
  });
  bool get isSuccess => success;
}