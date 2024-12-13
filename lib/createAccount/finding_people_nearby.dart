import 'dart:async';
import 'dart:ui' as ui;
import 'package:love_bird/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:love_bird/homeScreen/homeScreen.dart';
import 'package:love_bird/providers/image_provider.dart';
import 'package:provider/provider.dart';

class FindingPeopleNearBy extends StatefulWidget {
  const FindingPeopleNearBy({super.key});

  @override
  _FindingPeopleNearByState createState() => _FindingPeopleNearByState();
}

class _FindingPeopleNearByState extends State<FindingPeopleNearBy>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _dotTimer;
  int _dotCount = 0;
  ui.Image? _firstImage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
      });
    });

    _loadFirstImage();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  Future<void> _loadFirstImage() async {
    final firstImageFile =
        Provider.of<ImageProviderModel>(context, listen: false).images[0];
    if (firstImageFile != null) {
      final data = await firstImageFile.readAsBytes();
      final image = await decodeImageFromList(data);
      setState(() {
        _firstImage = image;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _dotTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = '.' * _dotCount;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.5,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CirclePainter(
                      animationValue: _animationController.value,
                      image: _firstImage,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Finding People Nearby$dots',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double animationValue;
  final ui.Image? image;

  CirclePainter({required this.animationValue, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    double baseInnerCircleRadius = size.width * .32;
    double baseMiddleCircleRadius = size.width * .42;
    double baseOuterCircleRadius = size.width * .52;

    double animatedInnerCircleRadius =
        baseInnerCircleRadius + (10 * animationValue);
    double animatedMiddleCircleRadius =
        baseMiddleCircleRadius + (15 * animationValue);
    double animatedOuterCircleRadius =
        baseOuterCircleRadius + (20 * animationValue);

    const double ringThickness = 20;

    final List<Color> ringColors = [
      blue.withOpacity(0.19),
      blue.withOpacity(0.57),
      const Color(0xFF4E41E8),
    ];

    _drawConcentricCircles(canvas, center, [
      CircleInfo(animatedInnerCircleRadius, ringThickness, ringColors[0]),
      CircleInfo(animatedMiddleCircleRadius, ringThickness, ringColors[1]),
      CircleInfo(animatedOuterCircleRadius, ringThickness, ringColors[2]),
    ]);

    // Check if `image` is not null before using it
    if (image != null) {
      double imageRadius = animatedInnerCircleRadius;
      Rect imageRect = Rect.fromCircle(center: center, radius: imageRadius);

      canvas.save();
      canvas.clipPath(Path()..addOval(imageRect));
      canvas.drawImageRect(
        image!,
        Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble()),
        imageRect,
        Paint(),
      );
      canvas.restore();
    }
  }

  void _drawConcentricCircles(
      Canvas canvas, Offset center, List<CircleInfo> circles) {
    final Paint paint = Paint()..style = PaintingStyle.stroke;

    for (CircleInfo circle in circles) {
      paint
        ..color = circle.color
        ..strokeWidth = circle.thickness;
      canvas.drawCircle(center, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is CirclePainter &&
        (oldDelegate.animationValue != animationValue ||
            oldDelegate.image != image);
  }
}

class CircleInfo {
  final double radius;
  final double thickness;
  final Color color;

  CircleInfo(this.radius, this.thickness, this.color);
}
