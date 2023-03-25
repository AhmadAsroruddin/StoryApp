import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  String name;
  Icon iconName;
  EmailField({required this.name, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return RoundedInputField(
      child: TextField(
        decoration: InputDecoration(
            hintText: name, icon: iconName, border: InputBorder.none),
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  RoundedInputField({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(top: size.height * 0.01, left: 30, right: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(20),
        ),
        child: child);
  }
}
