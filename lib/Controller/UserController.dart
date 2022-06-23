import 'dart:convert';
import 'package:product_api/Entity/ResponseAPI.dart';
import 'package:product_api/Entity/UserAccount.dart';
import 'package:product_api/Instrastructor/Singleton.dart';
import 'package:product_api/Response/ErrorResponse.dart';
import 'package:product_api/Response/SuccessResponse.dart';
import 'package:shelf/shelf.dart';

class UserController {
  Future getAll(Request request) async {
    var result =
        await Singleton.instance.connection.query('select * from useraccount');

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
    var obj = UserAccount.fromJson(jsonDecode(body));

    await Singleton.instance.connection.query(
        "INSERT INTO `sample_db`.`useraccount` (`username`, `email`, `password`) VALUES ('${obj.username}', '${obj.email}', '${obj.password}');");

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
        .query("DELETE from useraccount where username='${username}'");

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
    var obj = UserAccount.fromJson(jsonDecode(body));
    print(obj.toJson());
    await Singleton.instance.connection.query(
        "UPDATE `sample_db`.`useraccount` SET `username` = '${obj.username}', `email` = '${obj.email}', `password` = '${obj.password}' WHERE `username` = '${username}';");

    return Response.ok(
        SuccessResponse(description: 'operation successful', data: obj)
            .toResponse());
  }
}
