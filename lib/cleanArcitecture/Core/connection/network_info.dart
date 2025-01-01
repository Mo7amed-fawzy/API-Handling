import 'package:data_connection_checker_tv/data_connection_checker.dart';
// بكدج

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker); // ترو لو في نت وفولس لو مفيش

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
