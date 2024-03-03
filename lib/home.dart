import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.4, end: 0.6).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    ));

    _animationController?.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          color: Colors.white10,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: AnimatedBuilder(
            animation: _animationController!,
            builder: (BuildContext context, Widget? child) {
              return child!;
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * _animation!.value,
                  child: CustomPaint(
                    painter: PolygonePainter(),
                    size: const Size(30, 30),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * _animation!.value,
                  child: CustomPaint(
                    painter: PolygonePainter(),
                    size: const Size(80, 80),
                  ),
                ),
                //   CustomPaint(
                //     painter: PolygonePainter(),
                //     size: const Size(130, 130),
                //   ),
                //   CustomPaint(
                //     painter: PolygonePainter(),
                //     size: const Size(180, 180),
                //   ),
                //   CustomPaint(
                //     painter: PolygonePainter(),
                //     size: const Size(230, 230),
                //   ),
                //   CustomPaint(
                //     painter: PolygonePainter(),
                //     size: const Size(280, 280),
                //   ),
                //   CustomPaint(
                //     painter: PolygonePainter(),
                //     size: const Size(330, 330),
                //   ),
              ],
            ),
          )),
    );
  }
}

class PolygonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 3;
    paint.strokeJoin = StrokeJoin.round;
    paint.style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * .20, 0);
    path.lineTo(size.width * .80, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width * .80, size.height);
    path.lineTo(size.width * .20, size.height);
    path.lineTo(0, size.height / 2);
    canvas.drawPath(
        dashPath(path, dashArray: CircularIntervalList([5, 2])), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
