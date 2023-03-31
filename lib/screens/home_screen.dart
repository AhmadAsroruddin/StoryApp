import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import '../routes/router_delegate.dart';
import '../widget/story_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final apiProvider = context.read<StoriesProvider>();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          if (apiProvider.pageItems != null) {
            apiProvider.fetchAllStories();
          }
        }
      },
    );
    Future.microtask(() async => apiProvider.fetchAllStories());
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

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
            controller: scrollController,
            itemCount: value.result.length + (value.pageItems != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == value.result.length && value.pageItems != null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
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
