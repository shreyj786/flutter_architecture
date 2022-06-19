import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectivityChecker;

  NetworkInfoImpl(this.connectivityChecker);

  @override
  Future<bool> get isConnected => connectivityChecker.hasConnection;
}
