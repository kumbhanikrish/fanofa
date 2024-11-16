typedef EncryptionConfig = ({
  String encryptionKey,
  String encryptionIv,
  String decryptionKey,
  String decryptionIv,
});

class AppEnvironment {
  const AppEnvironment({
    String? baseApi,
    required this.baseUrl,
    required this.isLogEnabled,
    required this.userStorageUrl,
    required this.ticketStorageUrl,
    required this.userKycStorageUrl,
  }) : baseApi = baseApi ?? baseUrl;

  final String baseUrl;
  final String baseApi;
  final String userStorageUrl;
  final String ticketStorageUrl;
  final String userKycStorageUrl;
  final bool isLogEnabled;

  // "API_KEY_ENC": "25432A462D4A614E645267556B586E32",
  // "API_KEY_DEC": "472D4B6150645367566B587032733576",
  // "API_ENCRYPT_VI_KEY": "7A24432646294A40",
  // "API_DECRYPT_VI_KEY": "2A462D4A614E6452",
/*
  final EncryptionConfig encryption = (
    encryptionIv: "2A462D4A614E6452",
    decryptionIv: "7A24432646294A40",
    decryptionKey: "25432A462D4A614E645267556B586E32",
    encryptionKey: "472D4B6150645367566B587032733576",
  );*/

  static const development = AppEnvironment(
    baseUrl: "https://ef73-115-242-148-218.ngrok-free.app",
    baseApi: "https://ef73-115-242-148-218.ngrok-free.app/api/",
    userStorageUrl: "https://ef73-115-242-148-218.ngrok-free.app/user/",
    ticketStorageUrl: "https://ef73-115-242-148-218.ngrok-free.app/ticket/",
    userKycStorageUrl: "https://ef73-115-242-148-218.ngrok-free.app/user-kyc/",
    isLogEnabled: true,
  );

  static const staging = AppEnvironment(
    baseUrl: "",
    isLogEnabled: true,
    userStorageUrl: "",
    ticketStorageUrl: "",
    userKycStorageUrl: "",
  );

  static const production = AppEnvironment(
    baseUrl: "",
    isLogEnabled: false,
    userStorageUrl: "",
    ticketStorageUrl: "",
    userKycStorageUrl: "",
  );
}
