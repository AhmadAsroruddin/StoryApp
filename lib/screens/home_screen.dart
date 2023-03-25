import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import '../routes/router_delegate.dart';
import '../widget/story_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Story"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Provider.of<AuthProvider>(context, listen: false).logout();
              (Router.of(context).routerDelegate as MyRouterDelegate)
                  .onLogout();
            },
            child: const Text(
              "logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            (Router.of(context).routerDelegate as MyRouterDelegate)
                .onAddStory();
          },
          child: const Icon(Icons.add)),
      body: Consumer<StoriesProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.result.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await value.getDetail(value.result[index].id);
                  (Router.of(context).routerDelegate as MyRouterDelegate)
                      .onDeetailStory();
                },
                child: StoryWidget(
                    imageUrl: value.result[index].photoUrl,
                    name: value.result[index].name,
                    description: value.result[index].description),
              );
            },
          );
        },
      ),
    );
  }
}
