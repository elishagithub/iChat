import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectionManager {
  late StreamSubscription<ConnectivityResult> _subscription;

  void subscribeToConnectionChanges(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      switch (result) {
        case ConnectivityResult.none:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No Internet Connection'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          // Handle internet connection
          break;
        default:
          break;
      }
    });
  }

  void unsubscribeFromConnectionChanges() {
    _subscription.cancel();
  }
}
