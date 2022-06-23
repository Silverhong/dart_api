import 'dart:convert';

class SuccessResponse {
  bool? success;
  String? description = 'Operation Successful';
  dynamic? data = [];

  SuccessResponse({this.success, this.description, this.data});

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
  }

  String toResponse({int status = 200}) {
    return jsonEncode(
        {'success': true, 'description': description, 'data': data});
  }
}
