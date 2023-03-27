import 'package:flutter/material.dart';



class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter({required this.color});
  Color color;
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.8511097,size.height*0.3511405);
    path_0.cubicTo(size.width*0.8511097,size.height*0.1572196,size.width*0.6939219,0,size.width*0.4999851,0);
    path_0.cubicTo(size.width*0.3060781,0,size.width*0.1488903,size.height*0.1572196,size.width*0.1488903,size.height*0.3511405);
    path_0.cubicTo(size.width*0.1488903,size.height*0.4492336,size.width*0.1918123,size.height*0.5606410,size.width*0.2540928,size.height*0.6473440);
    path_0.lineTo(size.width*0.5000149,size.height*1.000000);
    path_0.lineTo(size.width*0.7459985,size.height*0.6472805);
    path_0.cubicTo(size.width*0.8201411,size.height*0.5412647,size.width*0.8511097,size.height*0.4491721,size.width*0.8511097,size.height*0.3511405);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.4999851,0);
    path_1.cubicTo(size.width*0.3060781,0,size.width*0.1488903,size.height*0.1572196,size.width*0.1488903,size.height*0.3511405);

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawPath(path_1,paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width*0.5000149,size.height);
    path_2.lineTo(size.width*0.7459985,size.height*0.6472805);
    path_2.cubicTo(size.width*0.8201233,size.height*0.5412647,size.width*0.8511078,size.height*0.4491701,size.width*0.8511078,size.height*0.3511405);
    path_2.cubicTo(size.width*0.8511097,size.height*0.1572196,size.width*0.6939219,0,size.width*0.4999851,0);

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = color;
    canvas.drawPath(path_2,paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width*0.8511097,size.height*0.3511405);
    path_3.cubicTo(size.width*0.8511097,size.height*0.1572196,size.width*0.6939219,0,size.width*0.4999851,0);

    Paint paint_3_fill = Paint()..style=PaintingStyle.fill;
    paint_3_fill.color = color;
    canvas.drawPath(path_3,paint_3_fill);

    Paint paint_4_fill = Paint()..style=PaintingStyle.fill;
    paint_4_fill.color = Color(0xffF44D71).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width*0.5000010,size.height*0.3311414),size.width*0.1578127,paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width*0.3422339,size.height*0.3311414);
    path_5.cubicTo(size.width*0.3422339,size.height*0.2440000,size.width*0.4128596,size.height*0.1733287,size.width*0.4999831,size.height*0.1733287);

    Paint paint_5_fill = Paint()..style=PaintingStyle.fill;
    paint_5_fill.color = Color(0xffFF6679).withOpacity(1.0);
    canvas.drawPath(path_5,paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width*0.4999851,size.height*0.1733446);
    path_6.cubicTo(size.width*0.5871107,size.height*0.1733446,size.width*0.6577978,size.height*0.2440000,size.width*0.6577978,size.height*0.3311573);
    path_6.cubicTo(size.width*0.6577978,size.height*0.4182828,size.width*0.5871266,size.height*0.4889065,size.width*0.4999851,size.height*0.4889065);

    Paint paint_6_fill = Paint()..style=PaintingStyle.fill;
    paint_6_fill.color = Color(0xffD60949).withOpacity(1.0);
    canvas.drawPath(path_6,paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width*0.6577819,size.height*0.3311414);
    path_7.cubicTo(size.width*0.6577819,size.height*0.4182670,size.width*0.5871107,size.height*0.4888906,size.width*0.4999693,size.height*0.4888906);

    Paint paint_7_fill = Paint()..style=PaintingStyle.fill;
    paint_7_fill.color = Color(0xffB50444).withOpacity(1.0);
    canvas.drawPath(path_7,paint_7_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

