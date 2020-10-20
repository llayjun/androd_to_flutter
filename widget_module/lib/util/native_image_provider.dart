import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:widget_module/channel/channel_util.dart';

/// 自定义ImageProvider用于读取原生资源中的图片
class NativeImageProvider extends ImageProvider<NativeImageProvider> {
  /// 需要从原生中去加载的图片名格式如： icon_back.png / icon_new.jpg
  final String imageName;

  /// Scale of the image
  final double scale;

  const NativeImageProvider(this.imageName, {this.scale: 1.0});

  Future<ui.Codec> _loadAsync(NativeImageProvider key) async {
    Uint8List image8 = await getNativeImage(imageName);
    return await ui.instantiateImageCodec(image8);
  }

  @override
  Future<NativeImageProvider> obtainKey(ImageConfiguration configuration) {
    return new SynchronousFuture<NativeImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(NativeImageProvider key, decode) {
    return new MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
    );
  }
}
