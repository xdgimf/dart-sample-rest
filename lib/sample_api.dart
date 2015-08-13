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
  @ApiMethod(method: 'GET', path: 'hello1/{name}')
  StringResponse hello(String name) {
    if (names.contains(name) == false) {
      throw new RpcError(HttpStatus.NOT_FOUND, 'Name not found', '$name doesn\'t exists');
    }

    return new StringResponse('Hello, $name');
  }

  @ApiMethod(method: 'GET', path: 'hello2/{name}')
  Future<StringResponse> helloAsync(String name) async {
    if (names.contains(name) == false) {
      throw new RpcError(HttpStatus.NOT_FOUND, 'Name not found', '$name doesn\'t exists');
    }

    return new StringResponse('Hello, $name');
  }

  @ApiMethod(method: 'GET', path: 'hello3/{name}')
  Future<StringResponse> helloAsyncWithCompleter(String name) {
    var completer = new Completer();

    if (names.contains(name)) {
      completer.complete(new StringResponse('Hello, $name'));
    } else {
      throw new RpcError(HttpStatus.NOT_FOUND, 'Name not found', '$name doesn\'t exists');
    }

    return completer.future;
  }

  @ApiMethod(method: 'GET', path: 'hello4/{name}')
  Future<StringResponse> helloAsyncWithCompleterAndDelay(String name) async {
    var completer = new Completer();

    new Future.delayed(const Duration(seconds: 1), () {
      if (names.contains(name)) {
        completer.complete(new StringResponse('Hello, $name'));
      } else {
        completer.completeError(new RpcError(HttpStatus.NOT_FOUND, 'Name not found', '$name doesn\'t exists'));
      }
    });

    return completer.future;
  }
}
