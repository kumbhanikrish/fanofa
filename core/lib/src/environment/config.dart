abstract class BaseConfig {
  final String baseUrl;
  final String baseApi;
  final bool isLogEnabled;
  final String encryptionKey;
  final String encryptionIv;
  final String decryptionKey;
  final String decryptionIv;

  const BaseConfig({
    required this.baseUrl,
    required this.baseApi,
    required this.isLogEnabled,
    required this.encryptionKey,
    required this.encryptionIv,
    required this.decryptionKey,
    required this.decryptionIv,
  });
}
