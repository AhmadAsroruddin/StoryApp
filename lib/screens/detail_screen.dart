import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/screens/map_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoriesProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(value.detailstory!.name),
          ),
          body: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.height * 1,
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/block.gif',
                      image: value.detailstory!.photoUrl),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Created By ${value.detailstory!.name}"),
                  Text("At ${value.detailstory!.createdAt}")
                ],
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                value.detailstory!.description,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              value.detailstory!.lat != null
                  ? Expanded(
                      child: MapScreen(
                        lat: double.parse(value.detailstory!.lat.toString()),
                        lon: double.parse(value.detailstory!.lon.toString()),
                      ),
                    )
                  : const Text("no location")
            ],
          ),
        );
      },
    );
  }
}
