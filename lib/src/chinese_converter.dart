import 'dart:async';

import 'package:flutter/services.dart';

import 'options.dart';

/// The Chinese converter.
class ChineseConverter {
  static const MethodChannel _channel =
      MethodChannel('flutter_open_chinese_convert');
  static List<ConverterOption> _options = [
    S2T(),
    T2S(),
    S2HK(),
    HK2S(),
    S2TW(),
    TW2S(),
    S2TWp(),
    TW2Sp(),
  ];

  /// All available options.
  static List<ConverterOption> get allOptions => _options;

  /// Converter input [text] with a given [option].
  ///
  /// For example:
  ///
  /// ``` dart
  /// var text = '鼠标里面的硅二极管坏了，导致光标分辨率降低。';
  /// var result = await ChineseConverter.convert(text, S2TWp());
  /// ```
  ///
  /// You can pass the [inBackground] parameter if you want to create native
  /// threads while doing text conversion.
  static Future<String?> convert(
    String text,
    ConverterOption option, {
    bool inBackground = false,
  }) async {
    final String? result =
        await _channel.invokeMethod('convert', [text, option.id, inBackground]);
    return result;
  }
}
