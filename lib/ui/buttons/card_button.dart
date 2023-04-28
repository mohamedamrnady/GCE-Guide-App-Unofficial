import 'package:flutter/material.dart';

class CardModel extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const CardModel({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: 40,
        width: double.infinity,
        child: Text(
          name,
          textScaleFactor: 1.25,
        ),
      ),
    );
  }
}
