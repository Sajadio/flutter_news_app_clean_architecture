import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomDelegate(
                    onClickQuery: (query) {
                      print(query);
                    },
                  ));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate {
  final void Function(String) onClickQuery;
  CustomDelegate({
    required this.onClickQuery,
  });

  final List<String> search = [
    'Apple',
    'Banana',
    'Cherry',
    'Durian',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Pineapple',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in search) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(matchQuery[index]),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in search) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onClickQuery(matchQuery[index]);
              close(context, null);
            },
            child: ListTile(
              title: Text(matchQuery[index]),
            ),
          );
        });
  }
}
