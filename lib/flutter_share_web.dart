import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/services.dart';

/// A web implementation of the FlutterShare plugin.
class FlutterShareWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_share',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = FlutterShareWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'share':
        final String title = call.arguments['title'];
        final String? text = call.arguments['text'];
        final String? linkUrl = call.arguments['linkUrl'];
        
        if (kIsWeb) {
          try {
            final shareData = {
              'title': title,
              'text': text ?? '',
              'url': linkUrl,
            };
            
            await html.window.navigator.share(shareData);
            return true;
          } catch (e) {
            return false;
          }
        }
        return false;

      case 'shareFile':
        // Web implementation for file sharing is not supported yet
        return false;

      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'flutter_share for web doesn\'t implement \'${call.method}\'',
        );
    }
  }
} 