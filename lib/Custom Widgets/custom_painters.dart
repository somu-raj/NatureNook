// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:nature_nook_app/color/colors.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// Define the center and radius of the circle
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    /// Create paint objects for the different parts of the circle
    final paint1 = Paint()
      ..color = NatureColor.whiteTemp
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final paint2 = Paint()
      ..color = NatureColor.whiteTemp.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    /// Draw the first three-quarters of the circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3 * 3.14159 / 2,
      3.14159 / 2,
      // 0,
      // 3 * 3.14159 /2,
      false,
      paint1,
    );

    /// Draw the remaining quarter of the circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      // 3 * 3.14159 / 2,
      0,
      3 * 3.14159 / 2,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
