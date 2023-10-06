import 'package:flutter/material.dart';

class SpeedMatchScreen extends StatefulWidget {
  const SpeedMatchScreen({super.key});

  @override
  State<SpeedMatchScreen> createState() => _SpeedMatchScreenState();
}

class _SpeedMatchScreenState extends State<SpeedMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
            ),
            fit: BoxFit.cover),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold();
        },
      ),      
    );
  }
}