import 'package:flutter/material.dart';

import '../config/config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Config.backgroundColor,
      iconTheme: const IconThemeData(
        color: Colors.indigo, //change your color here
      ),
      title: RichText(
        text: const TextSpan(
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
