import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _linearProgressController;
  late Animation<double> _linearProgressAnimation;

  @override
  void initState() {
    super.initState();

    _linearProgressController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _linearProgressAnimation = Tween<double>(begin: 0, end: 100).animate(_linearProgressController)
      ..addListener(() {
        setState(() {}); // Redraw the UI on each animation tick
      });
  }

  void _startLinearProgressAnimation() {
    _linearProgressController.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linear Indicator Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: _linearProgressAnimation.value / 100, // Normalize the value between 0 and 1
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            Text('Progress: ${_linearProgressAnimation.value.toStringAsFixed(2)}%'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startLinearProgressAnimation,
              child: Text('Start Animation'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _linearProgressController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }
}
