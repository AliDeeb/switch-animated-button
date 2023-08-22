import 'package:flutter/material.dart';
import 'package:switch_animated_button/switch_animated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Switch Animated Button',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SwitchAnimatedButton(
          value: switchValue,
          size: 75,
          activeColor: const Color.fromARGB(255, 7, 205, 13),
          inactiveColor: const Color.fromARGB(255, 227, 19, 12),
          duration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          onTap: () {
            setState(() {
              switchValue = !switchValue;
            });
          },
        ),
      ),
    );
  }
}
