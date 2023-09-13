import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detector',
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _numTaps = 0;
  int _numDoubleTaps = 0;
  int _numLongPress = 0;

  final double _boxSize = 150.0;
  double _posX = 0.0;
  double _posY = 0.0;

  void _center(BuildContext context) {
    setState(() {
      _posX = (MediaQuery.of(context).size.width / 2) - _boxSize / 2;
      _posY = (MediaQuery.of(context).size.height / 2) - _boxSize / 2 - kToolbarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_posX == 0) {
      _center(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Detector'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _posY,
            left: _posX,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _numTaps++;
                });
              },
              onDoubleTap: () {
                setState(() {
                  _numDoubleTaps++;
                });
              },
              onLongPress: () {
                setState(() {
                  _numLongPress++;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  double deltaX = details.delta.dx;
                  double deltaY = details.delta.dy;
                  _posX += deltaX;
                  _posY += deltaY;
                });
              },
              child: Container(
                width: _boxSize,
                height: _boxSize,
                decoration: const BoxDecoration(color: Colors.red),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('PosX : ${_posX.toStringAsFixed(0)}'),
                    Text('PosY : ${_posY.toStringAsFixed(0)}'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Taps: $_numTaps   Double Taps: $_numDoubleTaps   Long Press: $_numLongPress',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
