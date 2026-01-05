class BaseResponse<T> {
  final bool success;
  final String? errorMessage;
  final T? data;

  BaseResponse({
    required this.success,
    this.errorMessage,
    this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return BaseResponse<T>(
      success: json['success'] as bool,
      errorMessage: json['errorMessage'],
      data: json['data'] != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
}
