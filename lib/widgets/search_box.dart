import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Color fillColor;
  final bool filled;
  final String? hintText;
  final Function(String?)? onSearch;

  const SearchBox({
    Key? key,
    required this.controller,
    this.fillColor = Colors.white,
    this.filled = true,
    this.hintText = 'Search ...',
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
        suffixIcon: const Icon(Icons.search),
      ),
      onSubmitted: onSearch,
    );
  }
}
