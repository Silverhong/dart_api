class ResponseAPI {
  bool? success;
  String? description;
  dynamic? data;

  ResponseAPI({this.success, this.description, this.data});

  ResponseAPI.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'description': description, 'data': data};
  }
}
