import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

extension MapExtension on Map {
  void changeKeyName(String oldKey, String key) {
    this[key] = this[oldKey];
    remove(oldKey);
  }
}

extension HexColor on Color {
  String _generateAlpha({required int alpha, required bool withAlpha}) {
    if (withAlpha) {
      return alpha.toRadixString(16).padLeft(2, '0');
    } else {
      return '';
    }
  }

  String toHex({bool leadingHashSign = true, bool withAlpha = false}) {
    return '${leadingHashSign ? '#' : ''}'
            '${_generateAlpha(alpha: alpha, withAlpha: withAlpha)}'
            '${red.toRadixString(16).padLeft(2, '0')}'
            '${green.toRadixString(16).padLeft(2, '0')}'
            '${blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}

extension TextUtils on Text {
  bool willTextOverflow({required double maxWidth}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }

  Size get textSize {
    final textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

extension StringUtils on String {
  String get proper => this[0].toUpperCase() + substring(1);
}

extension IntUtils on int {
  String get kFormat => intl.NumberFormat.compact().format(this);
}
