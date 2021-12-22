import 'dart:ui';

import 'package:flutter/material.dart';

class ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  const ScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color(0x88000000),
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    const lineSize = 22;
    final width = rect.width;
    const borderWidthSize = 160;
    // 扫码框顶部高度
    const paddingTopHeight = 200;
    // 扫码框底部高度
    final paddingBottomHeight = paddingTopHeight + (width - borderWidthSize);
    // 扫码框左边宽度
    const paddingLeftWidth = borderWidthSize / 2;
    // 扫码框右边宽度
    final paddingRightWidth = width - borderWidthSize / 2;
    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      // 扫码框上方填充图形
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top, rect.right, paddingTopHeight + rect.top),
        paint,
      )
      // 扫码框下方填充图形
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top + paddingBottomHeight, rect.right, rect.bottom),
        paint,
      )
      // 扫码框左边填充图形
      ..drawRect(
        Rect.fromLTRB(rect.left, paddingTopHeight + rect.top,
            rect.left + paddingLeftWidth, rect.top + paddingBottomHeight),
        paint,
      )
      // 扫码框右边填充图形
      ..drawRect(
        Rect.fromLTRB(
            rect.left + paddingRightWidth,
            paddingTopHeight + rect.top,
            rect.right,
            rect.top + paddingBottomHeight),
        paint,
      );

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
        paddingLeftWidth + borderOffset + rect.left,
        paddingTopHeight + borderOffset + rect.top,
        rect.left + paddingRightWidth - borderOffset,
        rect.top + paddingBottomHeight - borderOffset);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

      //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

      //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

      //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
