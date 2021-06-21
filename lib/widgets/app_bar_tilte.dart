import 'package:flutter/material.dart';

class AppBarTilte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Photo',
            style: TextStyle(
              color: Color(0xFF0E0B0D),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Box',
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
