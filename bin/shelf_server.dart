library shelf.server;

import 'package:rpc/rpc.dart';

import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_rpc/shelf_rpc.dart' as shelf_rpc;

import 'package:redstone_shelf_rpc/sample_api.dart';

main() {
  // Create your RPC API Server.
  ApiServer apiServer = new ApiServer(prettyPrint: true);
  apiServer.addApi(new SampleApi());

  // Create a Shelf handler for your RPC API.
  var handler = shelf_rpc.createRpcHandler(apiServer);

  // Start serving with Shelf.
  io.serve(handler, 'localhost', 8080);
}