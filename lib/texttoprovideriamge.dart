import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';
import 'package:flutter/rendering.dart';

class TextToImageProvider extends ImageProvider<TextToImageProvider> {
  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;

  TextToImageProvider({
    required this.text,
    required this.textStyle,
    required this.width,
    required this.height,
  });

  @override
  Future<TextToImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<TextToImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(TextToImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: 1.0,
      informationCollector: () sync* {
        yield ErrorDescription('TextToImageProvider failed to load font for text "$text"');
      },
    );
  }

  Future<ui.Codec> _loadAsync(TextToImageProvider key) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();

    canvas.drawPaint(Paint()..color = Colors.transparent);

    final textBorderRect = RRect.fromRectAndRadius(Rect.fromLTWH(
      6, // Adjust the border width as needed
      10,
      textPainter.width - 10, // Adjust the border width as needed
      textPainter.height + 18,
    ), // Adjust the position and dimensions of the rectangle
        Radius.circular(10));

    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawRRect(textBorderRect, borderPaint);

    textPainter.paint(canvas, const Offset(-10, 16));

    final picture = recorder.endRecording();
    final image = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return await ui.instantiateImageCodec(bytes);
  }
}
