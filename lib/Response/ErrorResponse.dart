import 'dart:convert';

import 'package:shelf/shelf.dart';

class ErrorResponse {
  bool? success;
  String? description = 'Operation Failed';

  ErrorResponse({this.success, this.description});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
  }

  String toResponse({int status = 400}) {
    return jsonEncode({'success': false, 'description': description});
  }
}
