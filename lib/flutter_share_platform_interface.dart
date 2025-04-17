import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter/services.dart';

abstract class FlutterSharePlatform extends PlatformInterface {
  FlutterSharePlatform() : super(token: _token);

  static final Object _token = Object();
  static FlutterSharePlatform _instance = MethodChannelFlutterShare();

  static FlutterSharePlatform get instance => _instance;

  static set instance(FlutterSharePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<bool?> share({
    required String title,
    String? text,
    String? linkUrl,
    String? chooserTitle,
  }) {
    throw UnimplementedError('share() has not been implemented.');
  }

  Future<bool?> shareFile({
    required String title,
    required String filePath,
    String? text,
    String? chooserTitle,
    String fileType = '*/*',
  }) {
    throw UnimplementedError('shareFile() has not been implemented.');
  }
}

class MethodChannelFlutterShare extends FlutterSharePlatform {
  final MethodChannel _channel = const MethodChannel('flutter_share');

  @override
  Future<bool?> share({
    required String title,
    String? text,
    String? linkUrl,
    String? chooserTitle,
  }) async {
    final success = await _channel.invokeMethod('share', <String, dynamic>{
      'title': title,
      'text': text,
      'linkUrl': linkUrl,
      'chooserTitle': chooserTitle,
    });

    return success;
  }

  @override
  Future<bool?> shareFile({
    required String title,
    required String filePath,
    String? text,
    String? chooserTitle,
    String fileType = '*/*',
  }) async {
    final success = await _channel.invokeMethod('shareFile', <String, dynamic>{
      'title': title,
      'text': text,
      'filePath': filePath,
      'fileType': fileType,
      'chooserTitle': chooserTitle,
    });

    return success;
  }
} 