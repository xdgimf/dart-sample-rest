library sample_api;

import 'dart:async';
import 'dart:io';

import 'package:rpc/rpc.dart';

final List<String> names = ['Joe', 'John', 'Doe', 'Dohn'];

class StringResponse {
  String response;
  StringResponse(this.response);
}

@ApiClass(name: 'sample', version: 'v1')
class SampleApi {
  @ApiMethod(method: 'GET', path: 'hello/{name}')
  StringResponse hello(String name) {
    if (names.contains(name) == false) {
      throw new RpcError(HttpStatus.NOT_FOUND, 'Name not found', '$name doesn\'t exists');
    }

    return new StringResponse('Hello, $name');
  }

  @ApiMethod(method: 'GET', path: 'helloasync/{name}')
  Future<StringResponse> helloAsync(String name) async {
    if (names.contains(name) == false) {
      throw new RpcError(HttpStatus.NOT_IMPLEMENTED, 'Name not found', '$name doesn\'t exists');
    }

    return new StringResponse('Hello, $name');
  }
}
