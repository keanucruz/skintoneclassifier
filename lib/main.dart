import 'package:flutter/material.dart';

import 'home.dart';
import 'product.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SkinToneDetector(),
      debugShowCheckedModeBanner: false,
    );
  }
}
