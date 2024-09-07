import 'dart:ui';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFEEBCF).withOpacity(0.5), // Light peach
              Color(0xFFF69F46).withOpacity(0.9), // Light pink
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    //   Stack(
    //   children: [
    //     Image.asset('assets/images/background.jpg',
    //       width: double.infinity,
    //       height: double.infinity,
    //       fit: BoxFit.fill,
    //     ),
    //     BackdropFilter(
    //       filter: ImageFilter.blur(
    //         sigmaX: 0,
    //         sigmaY: 0,
    //       ),
    //       child: Container(
    //         color: Colors.blueGrey.withOpacity(0.2),
    //       ),
    //     )
    //   ],
    // );
  }
}
