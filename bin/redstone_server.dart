// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library redstone.server;

import 'package:rpc/rpc.dart';

import 'package:redstone/redstone.dart' as app;

import 'package:shelf_rpc/shelf_rpc.dart' as shelf_rpc;

import 'package:redstone_shelf_rpc/sample_api.dart';

main() {
  // Create your RPC API Server.
  ApiServer apiServer = new ApiServer(prettyPrint: true)
    ..addApi(new SampleApi());

  // Create a Shelf handler for your RPC API.
  var apiHandler = shelf_rpc.createRpcHandler(apiServer);

  // Setup handler
  app.setShelfHandler(apiHandler);

  // Disable default error page
  app.showErrorPage = false;

  // Setup Redstone
  app.setupConsoleLog();
  app.redstoneSetUp();

  // Start serving with Redstone
  app.start();
}
