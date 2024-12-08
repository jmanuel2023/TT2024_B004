import 'package:flutter/material.dart';
import 'dart:async';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<String> messages = [
    "Analizando tu imagen...",
    "Preparando resultado...",
    "Prediagnóstico generado..."
  ];
  int currentMessageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startMessageSequence();
  }

  void _startMessageSequence() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentMessageIndex < messages.length - 1) {
          currentMessageIndex++;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(204, 87, 54, 1),
            ),
            SizedBox(height: 20),
            Text(
              messages[currentMessageIndex],
              style: TextStyle(fontSize: 18, backgroundColor: Color.fromRGBO(204, 87, 54, 1)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

