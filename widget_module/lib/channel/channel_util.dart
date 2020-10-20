import 'dart:typed_data';

import 'package:flutter/services.dart';

/// 自定义读取原生图片的Channel
const MethodChannel _channel = const MethodChannel('com.millet.flutter/native_image');

/// 读取对应的原生图片
Future<Uint8List> getNativeImage(String imageName) async {
  Uint8List path = await _channel.invokeMethod('getNativeImage', imageName);
  return path;
}

/// 跳转到second Activity
Future<String> goToActivity() async {
  final String goActivity = await _channel.invokeMethod('toActivity');
  return goActivity;
}
