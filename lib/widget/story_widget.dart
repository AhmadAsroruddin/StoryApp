import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  StoryWidget(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.description});

  String imageUrl;
  String name;
  String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
              placeholder: 'assets/block.gif', image: imageUrl),
          Text(name),
          Text(description)
        ],
      ),
    );
  }
}
