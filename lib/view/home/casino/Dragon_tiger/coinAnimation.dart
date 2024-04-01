import 'dart:math';

import 'package:dashed_color_circle/dashed_color_circle.dart';
import 'package:flutter/material.dart';

class CoinSpringAnimation extends StatefulWidget {
  @override
  _CoinSpringAnimationState createState() => _CoinSpringAnimationState();
}

class _CoinSpringAnimationState extends State<CoinSpringAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animationX = Tween<double>(
      begin: 0,
      end: 60,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _animationY = Tween<double>(
      begin: 10,
      end: 60,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animationX.value, -_animationY.value),
          child: child,
        );
      },
      child: _buildCoin(),
    );
  }

  Widget _buildCoin() {
    Random random = Random();
    List<int> possibleNumbers = [10, 50, 100, 500, 1000];
    int randomNumberIndex = random.nextInt(possibleNumbers.length);
    int otherdatas = possibleNumbers[randomNumberIndex];
    return CoinsDesign(otherdatas);
  }
  Widget CoinsDesign(otherdatas) {
    Color color = Colors.red;
    if (otherdatas <= 10) {
      color = Colors.blueAccent;
    } else if (otherdatas == 10) {
      color = Colors.green;
    } else if (otherdatas == 50) {
      color = Colors.yellow;
    } else if (otherdatas == 100) {
      color = Colors.red;
    } else if (otherdatas == 500) {
      color = Colors.deepOrangeAccent;
    } else if (otherdatas == 1000) {
      color = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        backgroundColor: color,
        radius: MediaQuery.of(context).size.width / 60,
        child: Stack(
          children: [
            Center(
              child: DashedColorCircle(
                dashes: 12,
                emptyColor: Colors.grey,
                filledColor: Colors.white,
                fillCount: 12,
                size: MediaQuery.of(context).size.width / 30,
                gapSize:  MediaQuery.of(context).size.width / 40,
                strokeWidth: 2.0,
              ),
            ),
            Center(
              child: Text(
                otherdatas.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 80,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}