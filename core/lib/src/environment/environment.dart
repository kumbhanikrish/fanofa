import 'config.dart';

export 'config.dart';

abstract class Environment implements BaseConfig {
  const Environment();



  @override
  final String decryptionIv = "YYS53akCvgZa386h";
  @override
  final String decryptionKey = "nvv0D6S1noKJASe98iiWQQPdzY791me2";
  @override
  final String encryptionIv = "alqeeVGhWZWpHxYK";
  @override
  final String encryptionKey = "vBnTKJCx97o6UDmkXeP3OItzB9PGrOaf";
}

