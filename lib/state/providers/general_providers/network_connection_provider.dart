import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final networkConnectionProvider = StreamProvider.autoDispose<bool>((ref) {
  final controller = StreamController<bool>();
  final connectivity = InternetConnectionChecker();

  final sub = connectivity.onStatusChange.listen((snapshot) async {
    final internetConnection = await InternetConnectionChecker().hasConnection;
    if (internetConnection == true) {
      controller.add(internetConnection);
    } else {
      controller.add(false);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
