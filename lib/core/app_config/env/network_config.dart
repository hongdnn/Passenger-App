class NetworkConfig {
  NetworkConfig({
    required this.rhBaseUrl,
    required this.ggBaseUrl,
  });

  final String rhBaseUrl;
  final String ggBaseUrl;
  int get connectTimeoutMillis => 30000;
  int get receiveTimeoutMillis => 30000;
  Map<String, String> get headers => <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
}

class StagingNetworkConfig extends NetworkConfig {
  StagingNetworkConfig({
    required super.rhBaseUrl,
    required super.ggBaseUrl,
  });
}

class ProductionNetworkConfig extends NetworkConfig {
  ProductionNetworkConfig({
    required super.rhBaseUrl,
    required super.ggBaseUrl,
  });
}
