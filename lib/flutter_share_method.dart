import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// The method channel implementation of FlutterShare.
class FlutterShareMethod {
  /// The method channel used to communicate with the native platform.
  @visibleForTesting
  static const MethodChannel channel = MethodChannel('flutter_share');

  /// Registers this class as the default instance of FlutterShare.
  static void registerWith() {
    // Method channel setup is handled automatically by the Flutter framework
  }
} 