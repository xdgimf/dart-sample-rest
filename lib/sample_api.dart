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
  Future<StringResponse> hello(String name) async {
    if (names.contains(name) == false) {
      throw new RpcError(101, 'Name not found', '$name doesn\'t exists');
    }

    return new StringResponse('Hello, $name');
  }
}
