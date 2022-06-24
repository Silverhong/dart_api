import 'dart:convert';
import 'package:product_api/Entity/ResponseAPI.dart';
import 'package:product_api/Entity/UserProfile.dart';
import 'package:product_api/Instrastructor/Singleton.dart';
import 'package:product_api/Response/ErrorResponse.dart';
import 'package:product_api/Response/SuccessResponse.dart';
import 'package:shelf/shelf.dart';

class UserProfileController {
  Future getAll(Request request) async {
    var result =
        await Singleton.instance.connection.query('SELECT * FROM userprofile');

    var data = result.map((e) => e.fields).toList();

    var response = ResponseAPI(
            success: true, description: 'operation successful', data: data)
        .toJson();

    return Response.ok(jsonEncode(response));
  }

  Future post(Request request) async {
    var body = await request.readAsString();
    if (body.length == 0) {
      return Response.badRequest(
          body: ErrorResponse(description: 'please provide correct param')
              .toResponse());
    }
    var obj = UserProfile.fromJson(jsonDecode(body));

    await Singleton.instance.connection.query(
        "INSERT INTO `sample_db`.`userprofile` (`username`, `firstname`, `lastname`, `position`, `uploadimageurl1`, `uploadimageurl2`, `uploadimageurl3`, `uploadimageurl4`, `uploadimageurl5`, `uploadimageurl6`) VALUES ('${obj.username}', '${obj.firstname}', '${obj.lastname}', '${obj.position}', NULL, NULL, NULL, NULL, NULL, NULL);");

    return Response.ok(
        SuccessResponse(description: 'operation successful', data: obj)
            .toResponse());
  }

  Future delete(Request request, String username) async {
    if (username == null) {
      return Response.badRequest(
          body: ErrorResponse(description: 'please provide correct param')
              .toResponse());
    }

    await Singleton.instance.connection
        .query("DELETE from userprofile where username='${username}'");

    return Response.ok(
        SuccessResponse(description: 'operation successful').toResponse());
  }

  Future update(Request request, String username) async {
    if (username == null) {
      return Response.badRequest(
          body: ErrorResponse(description: 'please provide correct param')
              .toResponse());
    }

    var body = await request.readAsString();
    if (body.length == 0) {
      return Response.badRequest(
          body: ErrorResponse(description: 'please provide correct req body')
              .toResponse());
    }
    var obj = UserProfile.fromJson(jsonDecode(body));
    print(obj.toJson());
    await Singleton.instance.connection.query(
        "UPDATE `sample_db`.`userprofile` SET `firstname` = '${obj.firstname}', `lastname` = '${obj.lastname}', `position` = '${obj.position}', `uploadimageurl1` = NULL, `uploadimageurl2` = NULL, `uploadimageurl3` = NULL, `uploadimageurl4` = NULL, `uploadimageurl5` = NULL, `uploadimageurl6` = NULL WHERE `username` = '${username}';");

    return Response.ok(
        SuccessResponse(description: 'operation successful', data: obj)
            .toResponse());
  }
}
