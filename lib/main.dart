import 'dart:async' show Timer;
import 'dart:math' hide max;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Checking
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 00;
  int _minutes = 25;
  Timer? _timer;
  var min = NumberFormat("00");

  void _restartTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _seconds = 0;
      _minutes = 25;
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _seconds = false as int;
      _minutes = 25;
    }
  }

  void _startTimer() {
    if (_timer != null) {
      _restartTimer();
    }
    if (_minutes > 0) {
      _seconds = _minutes * 60;
    }
    if (_seconds > 60) {
      _minutes = (_seconds / 60).floor();
      _seconds -= (_minutes * 60);
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _seconds = 59;
            _minutes--;
          } else {
            _timer?.cancel();
            debugPrint("Timer Complete");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 239, 137, 65),
          title: const Text(
            'Pomodoro',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
      backgroundColor: const Color.fromARGB(121, 242, 189, 151),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${min.format(_minutes)} : ${min.format(_seconds)}",
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 254, 253),
                  fontSize: 48,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _startTimer();
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _stopTimer();
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Pause",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _restartTimer();
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Restart",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 106, 0),
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
