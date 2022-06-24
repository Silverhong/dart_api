import 'dart:convert';
import 'package:product_api/Entity/ResponseAPI.dart';
import 'package:product_api/Entity/Products.dart';
import 'package:product_api/Instrastructor/Singleton.dart';
import 'package:product_api/Response/ErrorResponse.dart';
import 'package:product_api/Response/SuccessResponse.dart';
import 'package:shelf/shelf.dart';

class ProductController {
  Future getAll(Request request) async {
    var result = await Singleton.instance.connection
        .query('select * from productmaster');

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
    var obj = Products.fromJson(jsonDecode(body));

    await Singleton.instance.connection.query(
        "INSERT INTO `sample_db`.`productmaster` (`productname`, `description`, `price`, `tax`, `size`, `quantity`) VALUES ('${obj.productname}', '${obj.description}', ${obj.price}, ${obj.tax}, '${obj.size}', ${obj.quantity});");

    return Response.ok(
        SuccessResponse(description: 'operation successful', data: obj)
            .toResponse());
  }

  Future delete(Request request, String id) async {
    if (id == null) {
      return Response.badRequest(
          body: ErrorResponse(description: 'please provide correct param')
              .toResponse());
    }

    await Singleton.instance.connection
        .query("DELETE from productmaster where id=${id}");

    return Response.ok(
        SuccessResponse(description: 'operation successful').toResponse());
  }

  Future update(Request request, String id) async {
    if (id == null) {
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
    var obj = Products.fromJson(jsonDecode(body));
    print(obj.toJson());
    await Singleton.instance.connection.query(
        "UPDATE `sample_db`.`productmaster` SET `productname` = '${obj.productname}', `description` = '${obj.description}', `price` = ${obj.price}, `tax` = ${obj.tax}, `size` = '${obj.size}', `quantity` = ${obj.quantity} WHERE `id` = ${id};");

    return Response.ok(
        SuccessResponse(description: 'operation successful', data: obj)
            .toResponse());
  }
}
